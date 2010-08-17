$:.push File.join(File.dirname(__FILE__), "..", "lib", "swc_parser")
$:.push File.dirname(__FILE__)

require "swf_xml_parser"
require "as3_class_data"

fixtures =  File.expand_path(File.join(File.dirname(__FILE__), "fixtures"))
swc = File.join(fixtures, "swc_files", "SWCParserTest.swc")
temp_directory = File.join(fixtures, "tmp")
output_directory = File.join(temp_directory, "data", "completions", "swc_completions", "intrinsics")
swf_xml_parser = SWCParser::SwfXmlParser.new()
swf_xml_parser.parse_swf( swc, temp_directory, output_directory )
FileUtils.remove_dir( temp_directory, true )