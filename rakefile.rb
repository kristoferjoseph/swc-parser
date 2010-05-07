require "rake/testtask"
require "rake/clean"

OUTPUT_DIR = File.join(File.expand_path(File.dirname(__FILE__)),"test", "fixtures", "swc_files")
SWC_NAME = "SWCParserTest.swc"
OUTPUT = File.join(OUTPUT_DIR, SWC_NAME)
as_classes = FileList["src/**/*"]

file OUTPUT => as_classes do
    system "compc -source-path src -output #{OUTPUT} -include-sources src"
end

CLEAN.add OUTPUT

desc "Compiles a SWC for testing"
task :compile => OUTPUT

task :test => :compile
  Rake::TestTask.new do |test| 
    test.libs << "test" 
    test.test_files = Dir[ "test/*_test.rb" ] 
    test.verbose = true
end

desc "Default"
task :default => [:test] do

end