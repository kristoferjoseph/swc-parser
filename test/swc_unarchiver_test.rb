#!/usr/bin/env ruby -w
require "test/unit"
require "lib/swc_unarchiver"

class SwcUnarchiverTest < Test::Unit::TestCase

  PATH_TO_SWC = File.expand_path(File.dirname(__FILE__)).gsub(/test/,'bin')
  TEMP_DIR = File.expand_path(File.dirname(__FILE__)).gsub(/test/,'tmp')

  def setup
    @swc_unarchiver = SwcUnarchiver.new
  end
  
  def test_that_temp_directory_is_created
    @swc_unarchiver.make_temp_directory
    assert File.directory?(TEMP_DIR)
  end
  
  def test_should_return_a_swf_path_from_a_swc
    assert_equal(@swc_unarchiver.get_swf_path_from_swc("#{PATH_TO_SWC}/SWCParserTest.swc"), "#{TEMP_DIR}/library.swf")
  end
 
end