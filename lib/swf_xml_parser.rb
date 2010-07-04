require 'rubygems'
gem 'rake'
require 'rake'
require 'zlib'
require 'fileutils'
require 'swc_unarchiver'
require 'rexml/document'
require "swf_xml_stream_listener"

class SwfXmlParser
  attr_accessor :do_abc_2_tags

  def parse_swf(swc, temp_directory=nil)
    swc_unarchiver = SwcUnarchiver.new()
    swf_file = swc_unarchiver.unpack_swc(swc, temp_directory)
    xml_file = swf_file.gsub( "swf", "xml" )
    system "swfdump -asm -out #{xml_file} #{swf_file}"
    @do_abc_2_tags = []
    file = File.new( xml_file )
    stream_listener = SwfXmlStreamListener.new()
    stream_listener.add_abc2_tag_complete_listener( method(:handle_abc2_tag_complete) )
    REXML::Document.parse_stream(file,stream_listener)
  end

  def handle_abc2_tag_complete(as3_class_data)
    puts "handle_abc2_tag_complete: #{as3_class_data}"
    @do_abc_2_tags << as3_class_data
  end

end
