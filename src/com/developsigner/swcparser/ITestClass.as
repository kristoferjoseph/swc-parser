//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright 2010 Developsigner
// 
////////////////////////////////////////////////////////////////////////////////

package com.developsigner.swcparser
{

/**
 * Interface describing the contract for TestClass
 * 
 * @langversion ActionScript 3.0
 * @playerversion Flash 10.0
 * 
 * @author Kristofer Joseph
 * @since  21.04.2010
 */
public interface ITestClass
{
	
	//--------------------------------------
	//  PUBLIC METHODS
	//--------------------------------------
	function testPublicMethod():void;
	function returnTheNumberFive():int;
	//--------------------------------------
	//  GETTER/SETTERS
	//--------------------------------------
	function get foo():String;
	function get bar():Number;
}

}

