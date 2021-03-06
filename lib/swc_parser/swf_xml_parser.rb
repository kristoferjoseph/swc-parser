require 'rubygems'
gem 'rake'
require 'rake'
require 'zlib'
require 'fileutils'
require 'rexml/document'


module SWCParser
  class SwfXmlParser
    attr_accessor :as3_classes

    def parse_swf(swc, temp_directory=nil, output_directory=nil)
      swc_unarchiver = SwcUnarchiver.new()
      @swc_file_name = get_swc_name(swc)
      @output_directory = output_directory
      swf_file = swc_unarchiver.unpack_swc(swc, temp_directory)
      xml_file = swf_file.gsub( "swf", "xml" )
      system "swfdump -asm -out #{xml_file} #{swf_file}"
      @as3_classes = []
      file = File.new( xml_file )
      doc = REXML::Document.new( file )
      parse_swf_xml( doc )
    end

    def parse_swf_xml(doc)
      # Parse all the Actionscript Byte Code elements
      doc.elements.each("swf/DoABC2") do |element|
        parse_do_abc_2_tag(element)
      end
    end

    def parse_do_abc_2_tag(doc)
      as3_data = As3ClassData.new()
      
      exclude_class = false
      
      # Skip excluded classes
      metadata_nodes = doc.get_elements("#{doc.xpath}//MetaDataNode")
      unless metadata_nodes.empty?
        metadata_nodes.each do |node|
          if node.has_attributes?
            if node.attributes["id"] == "ExcludeClass"
              exclude_class = true
            end
          end
        end
      end

      unless exclude_class
        # Parse the package and class name
        as3_data.fully_qualified_class_name = doc.attributes["name"]

        # Parse the super class name
        stringNode = doc.get_elements("#{doc.xpath}//baseclass/LiteralStringNode")
        if stringNode[0]
          as3_data.fully_qualified_super_class_name = stringNode[0].attributes["value"]
        end

        # See if we are dealing with an interface class
        interface_definition_node =  doc.get_elements("#{doc.xpath}//BinaryInterfaceDefinitionNode")
        if interface_definition_node[0]
          as3_data.is_interface = interface_definition_node[0].has_attributes?
        end

        # Parse the class modifier
        if as3_data.is_interface
          modifier = get_modifier interface_definition_node[0].elements['attrs/AttributeListNode'].attributes
        else
          binary_node = doc.get_elements("#{doc.xpath}//BinaryClassDefNode")[0]
          modifier = get_modifier binary_node.elements['attrs/AttributeListNode'].attributes unless binary_node.nil?
        end

        # Parse the interfaces
        interfaces = doc.get_elements("#{doc.xpath}//interfaces//IdentifierNode")
        unless interfaces.empty?
          interfaces.each do |e|
            as3_data.interfaces << e.attributes["name"]
          end
        end

        # Parse the public properties
        properties = doc.get_elements("#{doc.xpath}//VariableBindingNode")
        unless properties.empty?
          properties.each do |property|
            prop = As3Property.new
            qualifier_node = property.elements['TypedIdentifierNode/QualifiedIdentifierNode']
            prop.name = qualifier_node.attributes["name"]
            attribute_array = qualifier_node.elements['AttributeListNode'].attributes
            prop.modifier = get_modifier attribute_array

            if attribute_array["static"]
              prop.is_static = true
            else
              prop.is_static = false
            end

            value_node = property.elements['LiteralStringNode']
            if value_node
              prop.value = value_node.attributes['value']
            end

            type_node = property.elements['TypedIdentifierNode/MemberExpressionNode/selector/GetExpressionNode/IdentifierNode']
            if type_node
              prop.type = type_node.attributes['name']
            end

            as3_data.properties << prop
          end
        end

        # Parse all the methods
        methods = doc.get_elements("#{doc.xpath}//FunctionCommonNode")
        unless methods.empty?
          methods.each do |method|
            function = As3Method.new

            # Parse method name
            function.name = method.elements['QualifiedIdentifierNode'].attributes['name']
            function.is_constructor = (function.name == '$construct')

            # Parse method modifier
            modifier_attributes = method.elements['QualifiedIdentifierNode/AttributeListNode'].attributes
            function.modifier = get_modifier modifier_attributes

            # Parse if method is static
            if modifier_attributes["static"]
              function.is_static = true
            end

            # Parse function parameters
            parameter_selector = "#{method.xpath}//ParameterNode"
            parameters = method.get_elements(parameter_selector)
            unless parameters.empty?
              parameters.each do |parameter|
                param = As3MethodParam.new
                param.name = parameter.elements['identifier/IdentifierNode'].attributes['name']
                identifier_node = parameter.elements['type/MemberExpressionNode/selector/GetExpressionNode/IdentifierNode']
                param.type = identifier_node.attributes['name'] unless identifier_node.nil?
                default = parameter.elements['init/LiteralStringNode']
                if default && default.has_attributes?
                  param.default = default.attributes['value']
                end

                function.parameters << param
              end
            end

            # Parse function return type
            return_type_node = method.elements['FunctionSignatureNode/MemberExpressionNode/selector/GetExpressionNode/IdentifierNode']
            # We have to do this nil check here because constructors have no return type
            if return_type_node && return_type_node.has_attributes?
              function.return_type =  return_type_node.attributes['name']
            end

            as3_data.functions << function
          end
        end

        @as3_classes << as3_data
        write_out_intrinsic_class(as3_data)
      end
    end

    def get_modifier(array)
      modifier = ""
      if array["public"]
        modifier = "public"
      elsif array["private"]
        modifier = "private"
      elsif array["protected"]
        modifier = "protected"
      elsif array["internal"]
        modifier = "internal"
      end
      return modifier
    end

    def get_swc_name(swc)
      swc.split("/").pop().gsub(".swc","")
    end

    def find_class_by_name(name)
      @as3_classes.find { |klazz| klazz.class_name == name }
    end

    def write_out_intrinsic_class(class_data)
      output_path = File.join( @output_directory, @swc_file_name )
      FileUtils.mkdir_p(output_path)
      file = File.join( output_path, "#{class_data.class_name}.as" )
      File.open( file, 'w+') do |f|
        f.write class_data.to_s
      end
    end

  end
end
