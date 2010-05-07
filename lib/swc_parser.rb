$:.push File.dirname(__FILE__)
require 'rubygems'
require 'bundler'
Bundler.setup
require 'zlib'
require 'fileutils'
require 'swc_unarchiver'
require 'swc_extractor'
require 'abc_data'
require 'abc_parser'
require 'swf_header'
require 'swf_rect'

class SwcParser

  BYTE = 1
  WORD = 2
  DWORD = 4
  QWORD = 8
  ACTION3_DEFINE = 82
  ACTION3 = 72

  def initialize(swc, temp_directory=nil)
    swc_unarchiver = SwcUnarchiver.new()
    swf_file = swc_unarchiver.unpack_swc(swc, temp_directory)
    @file = File.new( swf_file, 'r' )
    @extractor = SwcExtractor.new
    @contents = nil
    @pos = 0
    @tag_pos = 0
    @on_disk_length = 0
    @defenition_tags = []
    @header = read_header
    @abc_data = parse_abc
  end

  def read_header
    header = SwfHeader.new
    header.signature =  read_bytes(SwfHeader::SIGNATURE_LENGTH)
    header.version = read_bytes(BYTE)
    header.length = @extractor.little_ui32( read_bytes(DWORD) )

    if header.compressed?
      len = @contents.size
      compressed_content = @contents.slice!( SwfHeader::FRAME_OFFSET...len )
      @contents += inflate( compressed_content )
    end

    throw RuntimeError.new( "<#{header.length}> expected but was <#{@contents.size}>" ) if @contents.size != header.length

    header.frame_size = read_rect
    header.frame_rate = @extractor.little_ui16( read_bytes(WORD) )
    header.frame_count = @extractor.little_ui16( read_bytes(WORD) )

    return header
  end

	def read_bytes( count )
		read_whole_file_and_close if @contents.nil?

		# if a byte only use the current position otherwise apply a range extraction
		range = cur = @pos
		@pos += count
		range = cur...@pos unless count == BYTE

		@contents[range]
	end

  def read_rect
    ub = read_bytes(BYTE)
    rect = SwfRect.new
    rect.nbits = ub
    rect.bytes = ub.chr + read_bytes( rect.required_bytes - 1 )

    return rect
  end

  def parse_abc
    abc = AbcData.new

    return abc
  end

  def find_tags
    while @pos < @on_disk_length
      tagBytes = @extractor.little_ui16(read_bytes(WORD))
      tagID = tagBytes >> 6
      length = tagBytes & 0x3F
      isBig = length == 0x3F
      if isBig
        length = @extractor.si32(read_bytes(DWORD))
      end
      bytes = read_bytes(length)

      if tagID == ACTION3_DEFINE
        parser = ABCParser.new
        parser.parse bytes
      end
    end
  end
  
  def inflate( compressed_contents )
		zstream = Zlib::Inflate.new
		inflated_contents = zstream.inflate( compressed_contents )
		zstream.finish
		zstream.close
		inflated_contents
	end
  
  def read_tag_bytes( bytes, count )

		# if a byte only use the current position otherwise apply a range extraction
		range = cur = @tag_pos
		@tag_pos += count
		range = cur...@tag_pos unless count == BYTE

		bytes[range]
	end
	
	
	def read_whole_file_and_close
		pos = @file.tell
		@file.seek( 0, IO::SEEK_END )
		end_pos = @file.tell
		@file.pos = pos
		@on_disk_length = end_pos - pos
		@contents = @file.read( @on_disk_length )
		@file.close
	end

end
