class As3ClassData
  attr_accessor :package
  attr_accessor :class_name
  attr_accessor :super_class
  attr_accessor :interface
  attr_accessor :constants
  attr_accessor :public_properties
  attr_accessor :methods
  
  def fully_qualified_class_name=(name)
    puts "Class name => #{name}"
    parts = name.split("/")
    @class_name = parts.pop
    @package = parts.join(".")
  end
  
end
