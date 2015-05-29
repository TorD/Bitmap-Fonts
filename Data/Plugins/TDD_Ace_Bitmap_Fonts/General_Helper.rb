#==============================================================================
# ** Module TDD::ABF::General_Helper
#------------------------------------------------------------------------------
# This mixin is used as a mixin or standalone helper for various calculations
#==============================================================================
module TDD
module ABF
module General_Helper
  module_function
  #--------------------------------------------------------------------------
  # * Calculate combined text width of bitmap font
  #--------------------------------------------------------------------------
  def calculate_text_width(str, font)
    if str.to_s.length > 1
      char_data = nil
      last_char = nil
      text_width = font.horizontal_adjustment.to_f * 2 
      str.to_s.each_char do |char|
        char_data = font.char_data_for(char)
        next unless char_data
        text_width += font.letter_spacing[0] + char_data.x_offset + char_data.x_advance
        text_width += font.kerning(last_char, char) if last_char
        last_char = char
      end
      text_width += char_data.width - char_data.x_advance if char_data
    else
      text_width = 0.0
      char_data = font.char_data_for(str.to_s)
      text_width += font.letter_spacing[0] + char_data.x_advance if char_data
    end
    text_width
  end
end
end
end