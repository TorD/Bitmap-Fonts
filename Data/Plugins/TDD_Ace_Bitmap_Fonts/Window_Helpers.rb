#==============================================================================
# ** Module TDD::ABF::Window_Helpers
#------------------------------------------------------------------------------
# This mixin is used to perform additional calculations in numerous window
# extensions
#==============================================================================
module TDD
module ABF
module Window_Helpers
  #--------------------------------------------------------------------------
  # * Get bitmap font window width
  #--------------------------------------------------------------------------
  def bitmap_font_window_width
    return false unless TDD::ABF::SETTINGS::AUTO_RESIZE_INTERFACE
    bitmap = Bitmap.new(1, 1)
    return @list.map{|i| bitmap.bitmap_text_width(i[:name])}.max + 32 if bitmap.bitmap_font?
    return false
  end
end
end
end