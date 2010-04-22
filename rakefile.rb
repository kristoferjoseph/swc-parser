#!/usr/bin/env ruby -w
require "rake/testtask"

OUTPUT_DIR = File.join(File.expand_path(File.dirname(__FILE__)),"bin")
SWC_NAME = "SWCParserTest.swc"
INCLUDE_CLASSES = "com.developsigner.swcparser.TestClass com.developsigner.swcparser.ITestClass"

task :test
  Rake::TestTask.new do |test| 
    test.libs << "test" 
    test.test_files = Dir[ "test/*_test.rb" ] 
    test.verbose = true
end

desc "Default"
task :default => [:compileSWC] do

end

desc "Compiles a SWC for testing"
task :compileSWC do
    system "compc -source-path src -output #{OUTPUT_DIR}/#{SWC_NAME} -include-classes #{INCLUDE_CLASSES}"
end