#==============================================================================
# ** Module TDD::ABF::Font_Database
#------------------------------------------------------------------------------
#  This module stores references to bitmap fonts loaded
#==============================================================================
module TDD
module ABF
module Font_Database
  module_function
  #--------------------------------------------------------------------------
  # * Load font
  # > font_data_file: The font data file to read
  #--------------------------------------------------------------------------
  def load_font(font_data_file, parser=nil)
    font = TDD::ABF::Bitmap_Font.new(font_data_file, parser)
    fonts[font.name] = font
    return font
  end
  #--------------------------------------------------------------------------
  # * Get fonts
  #--------------------------------------------------------------------------
  def fonts
    @@fonts ||= {}
  end
  #--------------------------------------------------------------------------
  # * Get font by font name
  #--------------------------------------------------------------------------
  def get_font(font_name)
    fonts[font_name]
  end
  #--------------------------------------------------------------------------
  # * Check if has font by name?
  #--------------------------------------------------------------------------
  def has_font?(font_name)
    fonts.keys.include?(font_name)
  end

  def default_is_bitmap?
    has_font?(TDD::ABF::SETTINGS::DEFAULT_FONT)
  end

  def get_default_font
    get_font(TDD::ABF::SETTINGS::DEFAULT_FONT)
  end
end
end
end