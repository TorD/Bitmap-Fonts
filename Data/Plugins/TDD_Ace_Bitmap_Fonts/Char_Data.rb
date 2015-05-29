#==============================================================================
# ** Module TDD::ABF::Char_Data
#------------------------------------------------------------------------------
# This class acts as an accessor and instance of individual character data
# entries.
#==============================================================================
module TDD
module ABF
class Char_Data
  attr_accessor :id
  attr_accessor :x
  attr_accessor :y
  attr_accessor :width
  attr_accessor :height
  attr_accessor :x_offset
  attr_accessor :y_offset
  attr_accessor :x_advance
  #--------------------------------------------------------------------------
  # * Initializer
  # > data_hash: Expects a standardized bitmap font data hash. See
  #              TDD::ABF::Standard_Font_Parser
  #--------------------------------------------------------------------------
  def initialize(data_hash={})
    data_hash.each do |key, val|
      instance_variable_set("@#{key}", val)
    end
  end
end
end
end