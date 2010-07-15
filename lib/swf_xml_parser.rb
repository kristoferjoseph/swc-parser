require 'rubygems'
gem 'rake'
require 'rake'
require 'zlib'
require 'fileutils'
require 'swc_unarchiver'
require 'rexml/document'
require 'as3_class_data'

class SwfXmlParser
  attr_accessor :as3_classes

  def parse_swf(swc, temp_directory=nil)
    swc_unarchiver = SwcUnarchiver.new()
    swf_file = swc_unarchiver.unpack_swc(swc, temp_directory)
    xml_file = swf_file.gsub( "swf", "xml" )
    system "swfdump -asm -out #{xml_file} #{swf_file}"
    @as3_classes = []
    file = File.new( xml_file )
    doc = REXML::Document.new( file )
    parse_swf_xml( doc )
  end

  def parse_swf_xml(doc)
    REXML::XPath.match( doc, "//DoABC2" ).each do |tag|
      as3_data = As3ClassData.new()
      @as3_classes << as3_data
    end
  end

end
