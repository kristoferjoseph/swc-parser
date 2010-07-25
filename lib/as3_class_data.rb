class As3ClassData
  attr_accessor :package
  attr_accessor :class_name
  attr_accessor :super_class
  attr_accessor :is_interface
  attr_accessor :interfaces
  attr_accessor :constants
  attr_accessor :properties
  attr_accessor :functions

  def initialize
    @package      = ""
    @class_name   = ""
    @super_class  = ""
    @is_interface = false
    @interfaces   = []
    @constants    = []
    @properties   = []
    @functions    = []
  end

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

  def find_property_by_name(name)
    return @properties.find { |prop| prop.name == name }
  end
  
  def find_function_by_name(name)
    return @functions.find { |function| function.name == name }
  end

end
