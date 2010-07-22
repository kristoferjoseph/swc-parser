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
    tags = []
    doc.elements.each("*/DoABC2") do |tag|
      parse_do_abc_2_tag(tag)
    end
  end
  
  def parse_do_abc_2_tag(tag)
    doc = REXML::Document.new(tag.to_s)
    root = doc.root
    as3_data = As3ClassData.new()
    as3_data.fully_qualified_class_name = root.attributes["name"]    
    stringNode = doc.get_elements('//baseclass/LiteralStringNode')
    if stringNode[0]
      as3_data.fully_qualified_super_class_name = stringNode[0].attributes["value"]
    end
    interfaces = doc.get_elements('//interfaces//IdentifierNode')
    as3_data.interfaces = []
    if interfaces.length
      interfaces.each do |e|
        as3_data.interfaces << e.attributes["name"]
      end
    end
    
    @as3_classes << as3_data
  end

end
