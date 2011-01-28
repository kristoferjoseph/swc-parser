# Flash Swc Parser
This project was made to add swc code completions to TextMate via the AS3 bundle.
I am currently working on integrating this into my own fork of the bundle [here](http://github.com/kristoferjoseph/actionscript3.tmbundle)

## Description

How it works:

    #WARNING swfdump has recently broken compatibility. If you want to keep using this project make sure to hang on to a version of swfdump from a Flex SDK prior to 4.5

*	Using swfdump to create an XML representation of the as3 classes in the swc, then parsing them into data objects.

	>Upside to this approach is that it will just work. Downside to this approach is that without forcing a possibly painful gem update process I am stuck using ruby's built in REXML; which is slower than hoped.


## License

	Copyright 2009-2010 Kristofer Joseph

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.