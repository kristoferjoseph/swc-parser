class SwcExtractor
  
  # Decodes a 64-bit unsigned integer in big endian format.
	#
	def big_ui64
	end


	# Decodes a 32-bit unsigned integer in big endian format.
	#
	def big_ui32( tmp = nil )
		convert_bytes('N',tmp)
	end

  # Decodes a 32-bit signed integer
  def si32( tmp = nil )
    convert_bytes('l',tmp)
  end

	# Decodes a 16-bit unsigned integer in big endian format.
	#
	def big_ui16( tmp = nil )
		convert_bytes('n',tmp)
	end
	

	# Decodes a 64-bit unsigned integer in little endian format.
	#
	def little_ui64
	end


	# Decodes a 32-bit unsigned integer in little endian format.
	#
	def little_ui32( tmp = nil )
		convert_bytes('V',tmp)
	end


	# Decodes a 16-bit unsigned integer in little endian format.
	#
	def little_ui16( tmp = nil )
		convert_bytes('v',tmp)
	end


	# Decodes a single unsigned byte.
	#
	def ui8( tmp = nil )
		convert_bytes('C',tmp)
	end

	private

	def convert_bytes( type, tmp = nil )
		tmp.unpack( type ).shift
	end
	
end