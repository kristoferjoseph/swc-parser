require 'rexml/document'
require 'rexml/streamlistener'
require 'as3_class_data'

class SwfXmlStreamListener

  include REXML::StreamListener

  DO_ABC_2_TAG = "DoABC2"

  def tag_start(name,attributes)
    if name == DO_ABC_2_TAG
      @abc_tag = true
      @as3_class_data = As3ClassData.new
      puts "\n"
      puts " ABC TAG START ".center(50,"#")
    end

    if @abc_tag
      #build Actionscript Byte Code object
      attributes.each do |tag|
        p "=> properties: #{tag[0]}, #{tag[1]}"
      end
    end
  end

  def tag_end(name)
    if name == DO_ABC_2_TAG
      @abc_tag = false
      @callback.call(@as3_class_data)
      puts " ABC TAG END ".center(50,"#")
      puts "\n"
    end
  end

  def text(data)
    if @abc_tag == true
      return if data =~ /^\w*$/     # whitespace only
      abbrev = data[0..40] + (data.length > 40 ? "..." : "")
      puts "  text:   #{abbrev}"
    end
  end

  def add_abc2_tag_complete_listener(callback)
    @callback = callback
  end

end
