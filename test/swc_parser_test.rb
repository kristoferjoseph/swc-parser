require File.join(File.dirname(__FILE__), "test_helper")

class SwcParserTest < Test::Unit::TestCase

  context "A SWC parser" do

    setup do
      @swc = File.join(fixtures, "swc_files", "SWCParserTest.swc")
      @temp_directory = File.join(fixtures, "tmp")
      @swc_parser = SwcParser.new()
      @abc_data_collection = @swc_parser.parse_abc(@swc, @temp_directory)
    end

    teardown do
      @swc_parser = nil
    end

    should "parse correct minor version" do
      data = @abc_data_collection.shift
      assert_equal 16, data.minor_version   
    end
    
    should "parse correct major version" do
      data = @abc_data_collection.shift
      assert_equal 46, data.major_version   
    end
  end

end
