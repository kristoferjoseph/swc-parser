require File.join(File.dirname(__FILE__), "test_helper")

class SwcParserTest < Test::Unit::TestCase
  
  def setup
    @swc = File.join(fixtures, "swc_files", "SWCParserTest.swc")
    @temp_directory = File.join(fixtures, "tmp")
    @swc_parser = SwcParser.new(@swc, @temp_directory)
  end
  
  def tear_down
    @swc_parser = nil
  end
  
  def test_should_parse_correct_minimum_version
    assert true
  end
  
end