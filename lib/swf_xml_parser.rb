require 'rubygems'
gem 'rake'
require 'rake'
require 'zlib'
require 'fileutils'
require 'swc_unarchiver'
require 'rexml/document'

class SwfXmlParser
  
  def parse_swf(swc, temp_directory=nil)
    swc_unarchiver = SwcUnarchiver.new()
    swf_file = swc_unarchiver.unpack_swc(swc, temp_directory)
    xml_file = swf_file.gsub( "swf", "xml" )
    system "swfdump -asm -out #{xml_file} #{swf_file}"
    file = File.new( xml_file )
    @document = REXML::Document.new(file)
    parse_classes
  end
  
  def parse_classes
    klazzez = REXML::XPath.match( @document, "//DoABC2")
    klazzez.each  do |klazz|
      metadata = REXML::XPath.each( klazz, "//MetaDataNode")
      metadata.each do |metadata_id|
         if metadata_id.attributes["id"] != "ExcludeClass"

          end
      end
    end
  end
  
  
end