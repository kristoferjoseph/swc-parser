//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2010 Developsigner
// 
////////////////////////////////////////////////////////////////////////////////

package com.developsigner.swcparser
{
	import flash.display.MovieClip;
	
	/**
	 * Class.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author Kristofer Joseph
	 * @since  03.01.2010
	 */
	public class TestClass extends MovieClip implements ITestClass, IOtherTestInterface
	{
		//---------------------------------------
		// CLASS CONSTANTS
		//---------------------------------------
		
		/**
		 * @private
		 */
		public static const TEST_CONSTANT:String = "my test constant";
		public static const ANOTHER_TEST_CONSTANT:String = "ANOTHER_TEST_CONSTANT";
		
		//---------------------------------------
		// GETTER / SETTERS
		//---------------------------------------
		
		private var _foo:String;

		public function get foo():String
		{ 
			return _foo; 
		}

		public function set foo(value:String):void
		{
			if (value !== _foo)
			{
				_foo = value;
			}
		}
		
		private var _bar:Number;

		public function get bar():Number
		{ 
			return _bar; 
		}

		public function set bar(value:Number):void
		{
			if (value !== _bar)
			{
				_bar = value;
			}
		}
		
		private var _baz:Object;

		public function get baz():Object
		{ 
			return _baz; 
		}

		public function set baz(value:Object):void
		{
			if (value !== _baz)
			{
				_baz = value;
			}
		}
		
		private var _dude:String;

		public function get dude():String
		{
			return _dude;
		}

		public function set dude(value:String):void
		{
			if (value !== _dude)
			{
				_dude = value;
			}
		}
		
		protected var fwee:String;
		public var fwi:Boolean;
		private var fwo:Number;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
	
		/**
		 * @constructor
		 */
		public function TestClass(lame:String)
		{
			super();
			lame = foo;
		}

		//---------------------------------------
		// STATIC METHODS
		//---------------------------------------
		
		public static function myStaticMethod():String
		{
			return "My goodness, you've gone and done it now."
		}
		
		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------
		
		public function testPublicMethod():void
		{
			trace("TestClass::testPublicMethod()");
		}
		
		public function testPublicMethodWithArgument(arg:String):void
		{
			trace("TestClass::testPublicMethodWithArgument()");
		}
		
		public function testPublicMethodWithArgumentAndReturnValue(firstArg:String="kumquat",secondArg:Number=0):String
		{
			trace("TestClass::testPublicMethodWithArgumentAndReturnValue()");
			return "The first Arg is: "+firstArg+" The second Arg is: "+secondArg;
		}
		
		public function returnTheNumberFive():int
		{
			return 5;
		}
		//---------------------------------------
		// PROTECTED METHODS
		//---------------------------------------
		protected function testProtectedMethod():void
		{
			trace("TestClass::testProtectedMethod()");
		}
		
		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		
		private function myPrivate():void
		{
			trace("TestClass::myPrivate()");
		}
	}

}