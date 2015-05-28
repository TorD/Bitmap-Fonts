#==============================================================================
# ** Module TDD::ABF::Bitmap_Font
#------------------------------------------------------------------------------
#  This class stores bitmap font data
#==============================================================================
module TDD
module ABF
class Bitmap_Font
  #--------------------------------------------------------------------------
  # * Initializer
  # > font_data: The data (String) to read
  # > parser: The parser method to use to retrieve data
  #--------------------------------------------------------------------------
  def initialize(font_data, parser = TDD::ABF::Standard_Font_Parser)
    @info, @char_data, @kerning_data, @file = parser.parse(font_data)
  end
  #--------------------------------------------------------------------------
  # * Get char data for a given character (String)
  # = (Hash) with character data
  #--------------------------------------------------------------------------
  def char_data_for(char_string)
    id = char_string.ord
    @char_data.select{|cd| cd.id == id}.first
  end
  def kerning(char, other_char)
    @kerning_data.select{|kd| kd.first == char.ord && kd.second == other_char.ord}.map{|r| r.amount}.max || 0
  end
  #--------------------------------------------------------------------------
  # * Get bitmap font image file
  # = (String) absolute path to image filename.extension
  #--------------------------------------------------------------------------
  def file
    @file
  end
  #--------------------------------------------------------------------------
  # * Get font name
  # = (String)
  #--------------------------------------------------------------------------
  def name
    @info[:face]
  end
  #--------------------------------------------------------------------------
  # * Get font size
  # = (Integer)
  #--------------------------------------------------------------------------
  def size
    @info[:size]
  end
  def calc_size
    (sizes.inject(:+).to_f / sizes.size) + padding[0]
  end
  def sizes
    [base, size, @info[:lineHeight]]
  end
  def padding
    @info[:padding]
  end
  def horizontal_adjustment
    TDD::ABF::SETTINGS::ADJUST_HORIZONTAL_DRAW_POSITION[name] || 0
  end
  def vertical_adjustment
    TDD::ABF::SETTINGS::ADJUST_VERTICAL_DRAW_POSITION[name] || 0
  end
  #--------------------------------------------------------------------------
  # * Check if bold
  # = (Boolean)
  #--------------------------------------------------------------------------
  def bold
    @info[:bold]
  end
  #--------------------------------------------------------------------------
  # * Check if italic
  # = (Boolean)
  #--------------------------------------------------------------------------
  def italic
    @info[:italic]
  end
  #--------------------------------------------------------------------------
  # * Get line height
  # = (Integer)
  #--------------------------------------------------------------------------
  def line_height
    TDD::ABF::SETTINGS::OVERRIDE_LINE_HEIGHT[name] || @info[:lineHeight]
  end
  #--------------------------------------------------------------------------
  # * Get letter spacing
  # = [x, y] (Array)
  #--------------------------------------------------------------------------
  def letter_spacing
    @info[:spacing]
  end
  #--------------------------------------------------------------------------
  # * Get base of font
  # = (Integer)
  #--------------------------------------------------------------------------
  def base
    @info[:base]
  end
  #--------------------------------------------------------------------------
  # * Get blank color object, for compatibility
  # = (Color)
  #--------------------------------------------------------------------------
  def color
    Color.new
  end
  #--------------------------------------------------------------------------
  # * Setters without function, for compatibility
  #--------------------------------------------------------------------------
  def name=(value); end
  def size=(value); end
  def bold=(value); end
  def italic=(value); end
  def outline=(value); end
  def out_color=(value); end
  def shadow=(value); end
end
end
end