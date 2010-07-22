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
    
    should "find DoABC2 tags" do
      assert_equal( 4, @swf_xml_parser.as3_classes.length )
    end
  
  end
  
end