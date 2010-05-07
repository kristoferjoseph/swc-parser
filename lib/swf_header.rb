class SwfHeader

  attr :length, true
  attr :version, true
  attr :frame_size, true
  attr :frame_rate, true
  attr :frame_count, true

  SIGNATURE = 'WS'
  COMPRESSION = 'C'
  NOCOMPRESSION = 'F'
  FRAME_OFFSET = 8
  SIGNATURE_LENGTH = 3

  def initialize
    @compressed = nil
  end

  # Throws an error if the signature is not valid for a SWF file up to Version 9.
  #
  def signature=( new_signature )
    compressed( new_signature[0].chr )
    throw ArgumentError.new( "Invalid file signature." ) if( new_signature[1..2] != SIGNATURE )
  end

  def compressed?
    throw RuntimeError.new( "Compression unknown." ) if @compressed.nil?
    @compressed
  end

  private
    def compressed( compressed )
      if( compressed == COMPRESSION )
        @compressed = true
      elsif( compressed == NOCOMPRESSION )
        @compressed = false
      else
        throw ArgumentError.new( "Incorrect compression specifier (#{compressed})." )
      end
    end
end
