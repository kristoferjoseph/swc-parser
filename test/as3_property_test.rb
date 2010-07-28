require File.join(File.dirname(__FILE__), "test_helper")

class As3PropertyTest < Test::Unit::TestCase

  context "An AS3 property" do
    
    should "render to string" do
      prop = As3Property.new
      prop.modifier = "public"
      prop.is_static = true
      prop.name = "fwee"
      prop.value = "fugnucket"
      prop.type = "String"
      assert_equal 'public static var fwee:String="fugnucket";', prop.to_s
    end
    
    should "render to string with numbers" do
      prop = As3Property.new
      prop.modifier = "protected"
      prop.is_static = false
      prop.name = "fwee"
      prop.value = "5"
      prop.type = "int"
      assert_equal 'protected var fwee:int=5;', prop.to_s
    end
    
    should "render to string with Classes" do
      prop = As3Property.new
      prop.modifier = "private"
      prop.is_static = false
      prop.name = "fwi"
      prop.value = "DisplayObject"
      prop.type = "Class"
      assert_equal 'private var fwi:Class=DisplayObject;', prop.to_s
    end
    
  end
  
end
