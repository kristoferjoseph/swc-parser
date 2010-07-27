class As3MethodParam
  attr_accessor :name
  attr_accessor :type
  attr_accessor :default
  
  def get_default
     "=#{@default}" unless @default.nil? 
  end
  
  def to_s
    "#{@name}:#{@type}#{get_default}"
  end
end