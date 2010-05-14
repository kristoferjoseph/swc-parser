
class AbcParser
  BYTE           = 1
  DWORD          = 4
  QWORD          = 8
  WORD           = 2

  def parse(content)
    p "parse content #{content}"
    @extractor             = SwcExtractor.new
    abc_data               = AbcData.new
    abc_data.flags         = parse_flags content
    p "flags #{abc_data.flags}"
    abc_data.name          = read_string_to_null content
    p "name #{abc_data.name}"
    abc_data.minor_version = parse_ui16 content
    puts "minor version #{abc_data.minor_version}"
    abc_data.major_version = parse_ui16 content
    p "major version #{abc_data.major_version}"
    abc_data.constants     = parse_constants content
    p "constants #{abc_data.constants}"
    abc_data
  end

  private

    def parse_flags(content)
      @extractor.little_ui32(read_bytes(content, DWORD))

    end

    def read_string_to_null(content)
      name = ''
      while(true)

        str = content.slice(0...1)
        break if(str[0] == 0x00)
        content.slice!(0...1)
        name << str
      end

      content.slice!(0...1)
      name
    end

    def parse_ui16(content)
      bytes = read_bytes(content, WORD)
      @extractor.little_ui16(bytes)
      #bytes.unpack('v');
    end

    def read_bytes(content, count)
      content.slice! 0...count
    end

    def parse_constants(content)
      # puts "----------------------------------------------"
      # puts content
      # puts "----------------------------------------------"

      int_count = read_u30 content
      p "int_count #{int_count}"
      integers = Array.new int_count

      for i in 0..int_count
        int = read_u32 content
        p "int #{int}"
        integers << int
      end

      uint_count = read_u30 content
      p "uint_count #{uint_count}"
      uints = Array.new uint_count

      for i in 0..uint_count
        uint = read_u32 content
        p "uint #{uint}"
        uints << uint
      end

      double_count = read_u30 content
      p "double_count #{double_count}"
      doubles = Array.new double_count

      for i in 0..double_count
        double = read_d64 content
        p "double #{double}"
        doubles << double
      end



      # puts "----------------"
      # puts "INDEX: #{constants_init_index}"
      # puts "TRAIT COUNT: #{trait_count}"
      #constants = read_string_to_null content # read_bytes content, trait_count
      # puts "constants: #{constants}"
      # 1.upto(trait_count) do
      #   @traits << Trait.new_from_io(io, @abc_file)
      # end
      # constants = read_string_to_null(content)
      # puts "constants: #{constants}"
      # puts constants.join("\n\n")

      #p "parse_constants #{constants}"
    end

    def read_u30(content)
      read_u32(content) & 0x3fffffff
    end

    def read_u8(content)
      @extractor.ui8(read_bytes(content, BYTE))
      #read_bytes(content, BYTE).unpack('C')
    end

    def read_u32(content)
      byte = read_u8 content
      puts "BYTE: #{byte}"

      shift = 0
      value = 0
      while byte != nil
        if byte & 0x80 == 0
          return value | (byte << shift)
        else
          value = value | ((byte &0x7F) << shift)
        end
        shift += 7
        byte = read_u8 content
      end

    end

    def read_d64(content)
      upper = read_u32 content
      lower = read_u32 content
      (upper << 32) | lower
    end

end



#
# class ConstantPool
#   attr_accessor :ints
#   attr_accessor :uints
#   attr_accessor :doubles
#   attr_accessor :strings
#   attr_accessor :namespaces
#   attr_accessor :ns_sets
#   attr_accessor :multinames
#   attr_accessor :cinit_index
#   attr_accessor :traits
#
#   def initialize io=nil
#     if io
#       read_from_io(io)
#     else
#       clear_arrays
#     end
#   end
#
#   def clear_arrays
#     @ints = [nil]
#     @uints = [nil]
#     @doubles = [nil]
#     @strings = [nil]
#     @namespaces = [nil]
#     @ns_sets = [nil]
#     @multinames = [Multiname.new(nil,nil,nil,nil,self)]
#   end
#
#   def find_arr(value, arr)
#     arr.index(value)
#   end
#
#   def self.new_from_io(io, abc_file=nil)
#     ns = Class.new(abc_file)
#     ns.read_from_io(io)
#   end
#
#   def initialize(abc_file=nil)
#     clear_arrays
#     @abc_file = abc_file
#   end
#
#   def clear_arrays
#     @traits = []
#   end
#
#   def inspect
#     "#<Class:0x#{object_id.to_s(16)} @cinit_index=#{@cinit_index} @traits=#{@traits}>"
#   end
#
#   def cinit
#     @abc_file.abc_methods[@cinit_index] if @abc_file and @cinit_index
#   end
#
#   def read_from_io(io)
#     clear_arrays
#
#     @cinit_index = io.read_u30
#     trait_count = io.read_u30
#     1.upto(trait_count) do
#       @traits << Trait.new_from_io(io, @abc_file)
#     end
#     self
#   end
#
#   def read_u30(io)
#     read_u32(io) & 0x3fffffff
#   end
#   def read_u32(io)
#     # read_mode_guard
#     # clear_bit_pos # needs rspec
#
#     byte = io.char
#     shift = 0
#     value = 0
#     while byte != nil
#       if byte & 0x80 == 0
#         return value | (byte << shift)
#       else
#         value = value | ((byte &0x7F) << shift)
#       end
#       shift += 7
#       byte = getc
#     end
#
#   end
#
#   def write_to_io(io)
#     io.write_u30 @cinit_index
#
#     io.write_u30 @traits.length
#     @traits.each { |t| t.write_to_io io }
#
#     self
#   end
#
#   def find_int(value)       find_arr(value, @ints)       end
#   def find_uint(value)      find_arr(value, @uints)      end
#   def find_double(value)    find_arr(value, @doubles)    end
#   def find_string(value)    find_arr(value, @strings)    end
#   def find_namespace(value) find_arr(value, @namespaces) end
#   def find_ns_set(value)    find_arr(value, @ns_sets)    end
#   def find_multiname(value) find_arr(value, @multinames) end
#
# end
