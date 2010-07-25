require File.join(File.dirname(__FILE__), "test_helper")

class SwfXmlParserTest < Test::Unit::TestCase
  
  context "A SWF XML Parser" do
    
    setup do
      @swc = File.join(fixtures, "swc_files", "SWCParserTest.swc")
      @temp_directory = File.join(fixtures, "tmp")
      @swf_xml_parser = SwfXmlParser.new()
      @swf_xml_parser.parse_swf( @swc, @temp_directory )
    end

    teardown do
      @swc = nil
      #remove_file @temp_directory
      @swf_xml_parser = nil
    end
    # 
    # should "Create SWF XMl file" do
    #   assert FileTest::exists?(File.join( @temp_directory, "library.xml"))
    # end
    # 
    # should "find AS3 class tags" do
    #   assert_equal( 4, @swf_xml_parser.as3_classes.length )
    # end
    # 
    # should "find class by name" do
    #   klazz = @swf_xml_parser.find_class_by_name "TestClass"
    #   assert_equal( "TestClass", klazz.class_name)
    # end
    # 
    # should "find properties on class" do
    #   klazz = @swf_xml_parser.find_class_by_name "TestClass"
    #   prop_1 = klazz.find_property_by_name "fwi"
    #   assert_equal( "fwi", prop_1.name)
    # end
    # 
    # should "parse property modifier from property node" do
    #   klazz = @swf_xml_parser.find_class_by_name "TestClass"
    #   prop_1 = klazz.find_property_by_name "fwi"
    #   assert_equal( "public", prop_1.modifier)
    # end
    # 
    # should "parse static properties" do
    #   klazz = @swf_xml_parser.find_class_by_name "TestClass"
    #   prop_1 = klazz.find_property_by_name "TEST_CONSTANT"
    #   assert( prop_1.is_static )
    # end
    # 
    # should "parse property value" do
    #   klazz = @swf_xml_parser.find_class_by_name "TestClass"
    #   prop_1 = klazz.find_property_by_name "TEST_CONSTANT"
    #   assert_equal( "my test constant", prop_1.value )
    # end
    # 
    # should "parse property type" do
    #   klazz = @swf_xml_parser.find_class_by_name "TestClass"
    #   prop = klazz.find_property_by_name "TEST_CONSTANT"
    #   assert_equal( "String", prop.type )
    #   klazz = @swf_xml_parser.find_class_by_name "TestClass"
    #   prop = klazz.find_property_by_name "_foo"
    #   assert_equal( "String", prop.type )
    # end
    # 
    should "find function on class" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      assert( !klazz.functions.empty? )
    end
    
    should "find function by name" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      func = klazz.find_function_by_name "foo"
      assert_equal( "foo", func.name )
    end
    
    should "parse function modifier" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      func = klazz.find_function_by_name "foo"
      assert_equal( "public", func.modifier )
    end
    
    should  "parse static methods" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      func = klazz.find_function_by_name "myStaticMethod"
      assert( func.is_static )
    end
    
    should "parse function parameters" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      func = klazz.find_function_by_name "testPublicMethodWithArgumentAndReturnValue"      
      assert( !func.parameters.empty? )
    end
    
  end
  
end