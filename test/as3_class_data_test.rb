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
      @as3_class_data.fully_qualified_class_name = "com/developsigner/swcparser/TestClass"
      assert_equal "TestClass", @as3_class_data.class_name
      assert_equal "com.developsigner.swcparser", @as3_class_data.package
    end
    
    should "return the correct super class name" do
      @as3_class_data.fully_qualified_super_class_name = "flash.display:MovieClip"
      assert_equal "MovieClip", @as3_class_data.super_class
      @as3_class_data.fully_qualified_super_class_name = "Object"
      assert_equal "Object", @as3_class_data.super_class
    end

  end

end
