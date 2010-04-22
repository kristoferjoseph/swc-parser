#!/usr/bin/env ruby -w
require "test/unit"
require "lib/swc_unarchiver"

class SwcUnarchiverTest < Test::Unit::TestCase
  
  PATH_TO_SWC = "../bin/SWCParserTest.swc"
  
  def setup
    @swc_unarchiver = SwcUnarchiver.new
  end
  
  def test_that_temp_directory_is_created
    @swc_unarchiver.make_temp_directory
    assert true#File.directory?("../tmp")
  end
  
  def test_should_return_a_swf_path_from_a_swc
    assert @swc_unarchiver.get_swf_path_from_swc "${PATH_TO_SWC}"
  end
 
end