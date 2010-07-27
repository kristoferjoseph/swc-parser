require File.join(File.dirname(__FILE__), "test_helper")

class As3MethodTest < Test::Unit::TestCase
  
  context "As3 Method Should" do
        
    should "render to string" do
      method_string = "public function doStuff(thing:String,doohickey:Number=8):Object;"
      method = As3Method.new
      method.modifier = "public"
      method.name = "doStuff"
      param_1 = As3MethodParam.new
      param_1.name = "thing"
      param_1.type = "String"
      param_2 = As3MethodParam.new
      param_2.name = "doohickey"
      param_2.type = "Number"
      param_2.default = 8
      method.parameters = [ param_1, param_2 ]
      method.return_type = "Object"
      assert_equal( method_string, method.to_s )
    end
    
  end

end