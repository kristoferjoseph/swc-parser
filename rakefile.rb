#!/usr/bin/env ruby -w
OUTPUT_DIR = File.join(File.expand_path(File.dirname(__FILE__)),"bin")
SWC_NAME = "SWCParserTest.swc"
INCLUDE_CLASSES = "com.developsigner.swcparser.TestClass com.developsigner.swcparser.ITestClass"

desc "Default"
task :default => [:compileSWC] do

end

desc "Compiles a SWC for testing"
task :compileSWC do
    system "compc -source-path src -output #{OUTPUT_DIR}/#{SWC_NAME} -include-classes #{INCLUDE_CLASSES}"
end