module SWCParser
  class As3ClassData
    attr_accessor :package
    attr_accessor :modifier
    attr_accessor :class_name
    attr_accessor :super_class
    attr_accessor :is_interface
    attr_accessor :interfaces
    attr_accessor :constants
    attr_accessor :properties
    attr_accessor :functions

    def initialize
      @package      = ""
      @modifier     = "public"
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

    def get_super_class
      " extends #{super_class}" unless super_class.nil? || super_class == ""
    end

    def get_interfaces
      unless @interfaces.empty?
        interface_string = " implements "
        @interfaces.each do |interface|
          if interface == @interfaces[@interfaces.length-1]
            interface_string << interface
          else
            interface_string << "#{interface},"
          end
        end
        interface_string
      end
    end

    def get_properties
      unless @properties.empty?
        @properties.collect do |prop|
          prop.to_s
        end.join("\n    ")
      end
    end

    def get_functions
      unless @functions.empty?
        function_strings = @functions.collect do |func|
          # Special handling for constructor
          func.name = class_name if func.is_constructor?
          func.to_s unless func_is_constructor_on_an_interface? func
        end
        function_strings.select {|str| str }.join("\n    ")
      end
    end
        
    def func_is_constructor_on_an_interface? func
      func.is_constructor? && @is_interface
    end

    def to_s
      result =<<EOF
package #{@package}
{
  #{@modifier} class #{@class_name}#{get_super_class}#{get_interfaces}
  {
    #{get_properties}
    #{get_functions}
  }
}

EOF
    end

  end
end
