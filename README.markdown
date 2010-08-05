# Flash Swc Parser
This project was made to add swc code completions to TextMate via the AS3 bundle.
I am currently working on integrating this into my own fork of the bundle [here](http://github.com/kristoferjoseph/actionscript3.tmbundle)

## Description

How it works:
There are two approaches taken in this repo; Each on it's own branch.

*	Using swfdump to create an XML representation of the as3 classes in the swc, then parsing them into data objects.

	>Upside to this approach is that it will just work. Downside to this approach is that without forcing a possibly painful gem update process I am stuck using ruby's built in REXML; which is slower than hoped.

*	Parsing the byte code from the swc file. This is based off of the amazing work of [Nathan Fisher](http://github.com/nfisher) and just simply adds ABC2 tag parsing to the [swfer](http://github.com/nfisher/ruby-swfer) lib.

	>Upside to this is that it is blazing fast. Downside to this is depending what version of ruby you are running the parsing is different. I am still trying to determine the best way to branch based on what ruby version the system has running. Needless to say this is still a work in progress. This can be found in the branch named byte_1.8.7

## Prerequisites

*	[TextMate](http://www.macromates.com)
*	[AS3 Bundle (kristofer joseph)](http://github.com/kristoferjoseph/actionscript3.tmbundle)


## Installation

* Open Terminal
* cd ~/Library/Application Support/$YOUR_USER_NAME/TextMate/Bundles/ 

	>If this directory doesn't exist then 
	*mkdir ~/Library/Application Support/$YOUR_USER_NAME/TextMate/Bundles/
	
* git clone http://github.com/kristoferjoseph/actionscript3-tmbundle.git
* In TextMate Go up north Bundles > Bundle Editor > Reload Bundles

 By default it will create a tmp directrory in /data and add the intrinsic classes in data/completions/intrinsics/$NAME__OF__SWC this will update anytime you add a new swc to your libs directory or update a swc there. This will add intrinsics from your swcs upon opening the project and will load your libs path from the lib path specified in your $NAME__OF__SWF-config.xml

## License

>Copyright 2009-2010 Kristofer Joseph

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