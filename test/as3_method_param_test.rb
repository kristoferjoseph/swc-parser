require File.join(File.dirname(__FILE__), "test_helper")

class As3MethodParamTest < Test::Unit::TestCase

    context "An AS3 method param" do
      
      should "render to string" do
        param = As3MethodParam.new
        param.name = "value"
        param.type = "String"
        param.default = "foo"
        assert_equal "value:String=foo", param.to_s
      end
      
    end
    
end