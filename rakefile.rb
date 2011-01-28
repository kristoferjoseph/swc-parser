require 'rubygems'
require 'bundler'

Bundler.require

require 'rake'
require 'rake/clean'
require 'rake/testtask'

# Used to compile a faux swc for fixtures
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

namespace :test do
  
  Rake::TestTask.new(:units) do |t| 
    t.libs << "test/unit" 
    t.test_files = FileList[ "test/unit/*_test.rb" ] 
    t.verbose = true
  end

end

desc "Run Tests"
task :test => 'test:units'