require 'rubygems'
gem 'rake'
require 'rake'
require 'zlib'
require 'fileutils'
require 'swc_unarchiver'
require 'rexml/document'
require 'as3_class_data'
require 'as3_property'
require "as3_method"

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
    # Parse all the Actionscript Byte Code elements
    doc.elements.each("*/DoABC2") do |tag|
      parse_do_abc_2_tag(tag)
    end
  end

  def parse_do_abc_2_tag(tag)
    doc = REXML::Document.new(tag.to_s)
    root = doc.root
    as3_data = As3ClassData.new()
    
    # Parse the package and class name
    as3_data.fully_qualified_class_name = root.attributes["name"]

    # Parse the super class name
    stringNode = doc.get_elements('//baseclass/LiteralStringNode')
    if stringNode[0]
      as3_data.fully_qualified_super_class_name = stringNode[0].attributes["value"]
    end

    # See if we are dealing with an interface class
    interface_defenition_node =  doc.get_elements('//BinaryInterfaceDefinitionNode')
    if interface_defenition_node[0]
      as3_data.is_interface = interface_defenition_node[0].has_attributes?
    end

    # Parse the interfaces
    interfaces = doc.get_elements('//interfaces//IdentifierNode')
    unless interfaces.empty?
      interfaces.each do |e|
        as3_data.interfaces << e.attributes["name"]
      end
    end

    # Parse the public properties
    properties = doc.get_elements('//VariableBindingNode')
    unless properties.empty?
      properties.each do |property|
        prop = As3Property.new
        prop.name = property.elements['*/QualifiedIdentifierNode'].attributes["name"]
        attribute_array = property.elements['*/QualifiedIdentifierNode/AttributeListNode'].attributes
        if attribute_array["public"]
          prop.modifier = "public"
        elsif attribute_array["private"]
          prop.modifier = "private"
        elsif attribute_array["protected"]
          prop.modifier = "protected"
        elsif attribute_array["internal"]
          prop.modifier = "internal"
        end

        if attribute_array["static"]
          prop.is_static = true
        else
          prop.is_static = false
        end
        
        if property.elements['LiteralStringNode']
          prop.value = property.elements['LiteralStringNode'].attributes['value']
        end
        
        if property.elements['*/MemberExpressionNode/selector/GetExpressionNode/IdentifierNode']
          prop.type = property.elements['*/MemberExpressionNode/selector/GetExpressionNode/IdentifierNode'].attributes['name']
        end
        
        as3_data.properties << prop
      end
    end
    
    # Parse all the methods
    methods = doc.get_elements('//FunctionCommonNode')
    unless methods.empty?
      methods.each do |method|
        function = As3Method.new
        
        # Parse method name
        function.name = method.elements['QualifiedIdentifierNode'].attributes['name']
        
        # Parse method modifier
        
        
        as3_data.functions << function
      end
    end

    @as3_classes << as3_data
  end

  def find_class_by_name(name)
    @as3_classes.find { |klazz| klazz.class_name == name }
  end

end
