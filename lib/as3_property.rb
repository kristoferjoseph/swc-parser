class As3Property
  attr_accessor :modifier
  attr_accessor :is_static
  attr_accessor :is_const
  attr_accessor :name
  attr_accessor :value
  attr_accessor :type
  
  def get_static
    " static" unless !@is_static
  end
  
  def get_value
    unless @value.nil?
      if @type == "String"
        "=\"""#{@value}""\""
      else
        "=#{@value}"
      end
    end
  end
  
  def to_s
    "#{@modifier}#{get_static} var #{@name}:#{@type}#{get_value}"
  end
  
end