require File.join(File.dirname(__FILE__), "..", "lib", "swc_parser")
$:.push File.dirname(__FILE__)

require "test/unit"

class Test::Unit::TestCase
  
  protected
  
  def fixtures
    File.expand_path(File.join(File.dirname(__FILE__), "fixtures"))
  end
  
end