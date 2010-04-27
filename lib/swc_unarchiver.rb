require "fileutils"

class SwcUnarchiver
  
  TEMP_DIRECTORY = File.expand_path(File.dirname(__FILE__)).gsub(/lib/,'tmp')
  
  def parse_swc(swc)
    make_temp_directory
    get_swf_path_from_swc(swc)
  end
  
  def get_swf_path_from_swc(swc)
    system "unzip -uo #{swc} -d #{TEMP_DIRECTORY}"
    if File.exist? "#{TEMP_DIRECTORY}/library.swf"
      return "#{TEMP_DIRECTORY}/library.swf"
    end
    
    raise "swc was not parsed correctly" 
  end
  
  def make_temp_directory
    FileUtils.mkdir_p(TEMP_DIRECTORY)
  end
  
end