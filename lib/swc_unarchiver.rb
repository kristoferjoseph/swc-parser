require "fileutils"

class SwcUnarchiver
  
  TEMP_DIRECTORY = "../tmp"
  
  def get_swf_path_from_swc(swc)
    #system "unzip -uo #{swc} -d "
    true
  end
  
  def make_temp_directory
    FileUtils.mkdir_p("../tmp")
  end
  
end