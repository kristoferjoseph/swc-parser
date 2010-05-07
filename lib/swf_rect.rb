class SwfRect
  NBITS_FIELD_LENGTH = 5
  BYTE_SIZE = 8
  attr :min_x, true
  attr :min_y, true
  attr :max_x, true
  attr :max_y, true

  def initialize
    @nbits = nil
  end

  def required_bytes
    return nil if @nbits.nil?

    @required_bytes = ( (@nbits * 4 + 5) / 8.0 ).ceil
  end

  def nbits
    @nbits
  end

  def nbits=( byte )
    ub = byte
    ub &= 0b11111000
    @nbits = ub >> 3
  end


  #
  # bytes=: extracts the min and max for x and y.
  #
  def bytes=( bytes )
    @bytes = 0

    len = bytes.size
    i = 0

    values = bytes.unpack( "C*" )

    values.each do |value|
      @bytes |= value
      @bytes = @bytes << BYTE_SIZE unless (i += 1) == len
    end

    @min_x = at( 0 )
    @max_x = at( 1 )
    @min_y = at( 2 )
    @max_y = at( 3 )
  end

  private

    def at( i )
      value = 0

      initial_offset = required_bytes * BYTE_SIZE - NBITS_FIELD_LENGTH

      first =	initial_offset - ( i * @nbits )
      last = first - @nbits

      sign_bit = @bytes[first]

      (last...(first-1)).to_a.reverse_each do |i|
        value |= @bytes[i]
        value = value << 1 unless i == last
      end

      value
    end
end
