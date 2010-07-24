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
    
    should "Create SWF XMl file" do
      assert FileTest::exists?(File.join( @temp_directory, "library.xml"))
    end
    
    should "find AS3 class tags" do
      assert_equal( 4, @swf_xml_parser.as3_classes.length )
    end
    
    should "find class by name" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      assert_equal( "TestClass", klazz.class_name)
    end
    
    should "find properties on class" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      prop_1 = klazz.find_property_by_name "fwi"
      assert_equal( "fwi", prop_1.name)
    end
    
    should "parse property modifier from property node" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      prop_1 = klazz.find_property_by_name "fwi"
      assert_equal( "public", prop_1.modifier)
    end
    
    should "parse static properties" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      prop_1 = klazz.find_property_by_name "TEST_CONSTANT"
      assert( prop_1.is_static )
    end
    
    should "parse property value" do
      klazz = @swf_xml_parser.find_class_by_name "TestClass"
      prop_1 = klazz.find_property_by_name "TEST_CONSTANT"
      assert_equal( "my test constant", prop_1.value )
    end
    
  end
  
end