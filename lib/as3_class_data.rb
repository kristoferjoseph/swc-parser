class As3ClassData
  attr_accessor :package
  attr_accessor :class_name
  attr_accessor :super_class
  attr_accessor :interface
  attr_accessor :constants
  attr_accessor :public_properties
  attr_accessor :methods
  
  def fully_qualified_class_name=(name)
    parts = name.split("/")
    @class_name = parts.pop
    @package = parts.join(".")
  end
  
  def fully_qualified_super_class_name=(name) 
    if name.include? ":"
      @super_class = name.split(":").pop
    else
      @super_class = name
    end
  end
end
