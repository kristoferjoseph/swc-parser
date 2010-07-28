$:.push File.join(File.dirname(__FILE__), "..", "lib", "swc_parser")
$:.push File.dirname(__FILE__)

require "swf_xml_parser"
require "as3_class_data"

require 'bundler'
Bundler.require :development

require "test/unit"

class Test::Unit::TestCase
  
  protected
  
  def fixtures
    File.expand_path(File.join(File.dirname(__FILE__), "fixtures"))
  end
  
end