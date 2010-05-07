
class SwcUnarchiver
    
  def unpack_swc(swc, target_directory="tmp")
    target_directory = File.expand_path(target_directory)
    make_temp_directory(target_directory)
    get_swf_path_from_swc(swc, target_directory)
  end
  
  private

  def get_swf_path_from_swc(swc, target_directory)
    system "unzip -uo #{swc} -d #{target_directory} >/dev/null"
    if File.exist? "#{target_directory}/library.swf"
      return "#{target_directory}/library.swf"
    end
    
    raise "swc was not parsed correctly" 
  end
  
  def make_temp_directory(target_directory)
    FileUtils.mkdir_p(target_directory)
  end
  
end