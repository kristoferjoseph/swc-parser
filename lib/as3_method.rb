class As3Method
  attr_accessor :modifier
  attr_accessor :is_static
  attr_accessor :name
  attr_accessor :parameters
  attr_accessor :return_type
  
  def initialize
    @modifier    = ""
    @is_static   = false
    @name        = ""
    @parameters  = []
    @return_type = []
  end
  
  def find_parameter_by_name(name)
    return @parameters.find { |parameter| parameter.name == name }
  end
  
end