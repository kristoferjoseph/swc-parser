require File.join(File.dirname(__FILE__), "test_helper")

class As3ClassDataTest < Test::Unit::TestCase

  context "As3 Class Data Should" do

    setup do
      @as3_class_data = As3ClassData.new
    end

    teardown do
      @as3_class_data = nil
    end
    
    should "Return the correct package and class name given a DoABC2 tag name attribute" do
      @as3_class_data.do_abc_2_tag_name_attribute = "com/developsigner/swcparser/TestClass"
      assert_equal "TestClass", @as3_class_data.class_name
      assert_equal "com.developsigner.swcparser", @as3_class_data.package
    end

  end

end
