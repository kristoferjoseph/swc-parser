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
  
end