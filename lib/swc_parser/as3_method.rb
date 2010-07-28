module SWCParser
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
      @return_type = ""
    end

    def find_parameter_by_name(name)
      return @parameters.find { |parameter| parameter.name == name }
    end

    def get_parameters
      str = ""
      @parameters.each do |parameter|
        if parameter == parameters[parameters.length-1]
          str << parameter.to_s
        else
          str << "#{parameter.to_s},"
        end
      end
      str
    end

    def get_return_type
      # Special handling for the constructor
      ":#{return_type}" unless return_type == ""
    end

    def to_s
      "#{@modifier} function #{name}(#{get_parameters})#{get_return_type};"
    end

  end

end
