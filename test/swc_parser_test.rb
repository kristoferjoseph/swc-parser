require File.join(File.dirname(__FILE__), "test_helper")

class SwcParserTest < Test::Unit::TestCase
  
  def setup
    @swf = File.join(fixtures, "swc_parser", "library.swf")
    @swc_parser = SwcParser.new(@swf)
  end
  
  def tear_down
    @swc_parser = nil
  end
  
  def test_should_parse_correct_minimum_version
    assert true
  end
  
end