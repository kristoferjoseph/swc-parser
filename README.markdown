# Flash Swc Parser
This project was made to add swc code completions to TextMate via the AS3 bundle.
I am currently working on integrating this into my own fork of the bundle [here](http://github.com/kristoferjoseph/actionscript3.tmbundle)

## Description

How it works:
There are two approaches taken in this repo; Each on it's own branch.

*	Using swfdump to create an XML representation of the as3 classes in the swc, then parsing them into data objects.

	>Upside to this approach is that it will just work. Downside to this approach is that without forcing a possibly painful gem update process I am stuck using ruby's built in REXML; which is slower than hoped.

*	Parsing the byte code from the swc file. This is a fork of the amazing work of __ and just simply adds ABC2 tag parsing to the [swfer](http://github/someone/swfer) lib (Only for those running ruby 1.8.7). There is also a branch using the [redsun](http://github/someone/redsun) lib for ruby 1.9.1 in progress.

	>Upside to this is that it is blazing fast. Downside to this is depending what version of ruby you are running the parsing is different. I am still trying to determine the best way to branch based on what ruby version the system has running. Needless to say this is still a work in progress. This can be found in the branch named byte

## Prerequisites

*	[TextMate](http://www.macromates.com)
*	[AS3 Bundle](http://github.com/simongregory/actionscript3.tmbundle)

**OR**

*	[AS3 Bundle (kristofer joseph)](http://github.com/kristoferjoseph/actionscript3.tmbundle)


## Installation

After installing the actionscript3.tmbundle you can clone this repo and drop the lib/swc_parser folder into the actionscript3.tmbundles lib folder. By default it will create a tmp directrory in /data and add the intrinsic classes in data/completions/intrinsics/$NAME__OF__SWC this will update anytime you add a new swc to your libs directory or update a swc there. This will add intrinsics from your swcs upon opening the project and will load your libs path from the lib path specified in your $NAME__OF__SWF-config.xml

OR you can install my fork of the official bundle and have this functionality out of the box.