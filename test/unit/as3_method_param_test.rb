require 'test_helper'

class As3MethodParamTest < Test::Unit::TestCase

    context "An AS3 method param" do
      
      should "render to string" do
        param = SWCParser::As3MethodParam.new
        param.name = "value"
        param.type = "String"
        param.default = "foo"
        assert_equal "value:String=foo", param.to_s
      end
      
      should "render to string without default" do
        param = SWCParser::As3MethodParam.new
        param.name = "displayObject"
        param.type = "DisplayObject"
        assert_equal "displayObject:DisplayObject", param.to_s
      end
      
    end
    
end