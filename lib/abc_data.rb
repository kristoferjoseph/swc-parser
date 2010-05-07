# abcFile {
# u16 minor_version 
# u16 major_version 
# cpool_info constant_pool 
# u30 method_count 
# method_info method[method_count] 
# u30 metadata_count 
# metadata_info metadata[metadata_count] 
# u30 class_count 
# instance_info instance[class_count] 
# class_info class[class_count] 
# u30 script_count 
# script_info script[script_count] 
# u30 method_body_count 
# method_body_info method_body[method_body_count]
# }

class AbcData
  attr_accessor :flags
  attr_accessor :name
  attr_accessor :constants
  ##
  # The minor version (u16)
  attr_accessor :minor_version
  ##
  # The major version (u16)
  attr_accessor :major_version
end