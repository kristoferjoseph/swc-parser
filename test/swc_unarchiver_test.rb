#!/usr/bin/env ruby -w
require "test/unit"
require "lib/swc_unarchiver"

class SwcUnarchiverTest < Test::Unit::TestCase

  PATH_TO_SWC = File.expand_path(File.dirname(__FILE__)).gsub(/test/,'bin')
  TEMP_DIR = File.expand_path(File.dirname(__FILE__)).gsub(/test/,'tmp')

  def setup
    @swc_unarchiver = SwcUnarchiver.new
  end
  
  def tear_down
    @swc_unarchiver = nil
    
  end
    
  def test_parse_swc
    assert File.directory?(TEMP_DIR)
    assert_equal(@swc_unarchiver.unpack_swc("#{PATH_TO_SWC}/SWCParserTest.swc"), "#{TEMP_DIR}/library.swf")
  end
 
end