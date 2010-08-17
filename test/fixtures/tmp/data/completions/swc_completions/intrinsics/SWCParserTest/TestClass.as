package com.developsigner.swcparser
{
  public class TestClass extends MovieClip implements ITestClass,IOtherTestInterface
  {
    private var _foo:String;
    private var _bar:Number;
    private var _baz:Object;
    private var _dude:String;
    protected var fwee:String;
    public var fwi:Boolean;
    private var fwo:Number;
    public static var TEST_CONSTANT:String="my test constant";
    public static var ANOTHER_TEST_CONSTANT:String="ANOTHER_TEST_CONSTANT";
    public function foo():String;
    public function foo(value:String):void;
    public function bar():Number;
    public function bar(value:Number):void;
    public function baz():Object;
    public function baz(value:Object):void;
    public function dude():String;
    public function dude(value:String):void;
    public function testPublicMethod():void;
    public function testPublicMethodWithArgument(arg:String):void;
    public function testPublicMethodWithArgumentAndReturnValue(firstArg:String=kumquat,secondArg:Number):String;
    public function returnTheNumberFive():int;
    protected function testProtectedMethod():void;
    private function myPrivate():void;
    public function TestClass(lame:String);
    public function myStaticMethod():String;
  }
}

