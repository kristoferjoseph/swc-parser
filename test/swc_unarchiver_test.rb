require File.join(File.dirname(__FILE__), "test_helper")

class SwcUnarchiverTest < Test::Unit::TestCase

  def setup
    @swc_unarchiver = SwcUnarchiver.new
    @input = File.join(fixtures, "swc_files", "SWCParserTest.swc")
    @target_directory = File.join(fixtures, "swc_unarchiver", "tmp")
    @expected_output = File.join(@target_directory, "library.swf")
  end
  
  def tear_down
    @swc_unarchiver = nil
    
  end
    
  def test_parse_swc
    assert_equal(@swc_unarchiver.unpack_swc(@input, @target_directory), @expected_output)
    assert File.directory?(@target_directory)
  end
 
end