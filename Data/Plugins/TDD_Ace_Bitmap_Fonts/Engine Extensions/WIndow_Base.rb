class Window_Base < Window
  #--------------------------------------------------------------------------
  # * EXTEND Line Height
  #--------------------------------------------------------------------------
  # alias_method :original_line_height_tdd_abf, :line_height
  # def line_height
  #   if TDD::ABF::Font_Database.default_is_bitmap?
  #     TDD::ABF::Font_Database.get_default_font.size
  #   else
  #     original_line_height_tdd_abf
  #   end
  # end
  #--------------------------------------------------------------------------
  # * EXTEND Calculate Line Height
  #     restore_font_size : Return to original font size after calculating
  #--------------------------------------------------------------------------
  alias_method :original_calc_line_height_tdd_abf, :calc_line_height
  def calc_line_height(text, restore_font_size = true)
    if TDD::ABF::Font_Database.default_is_bitmap?
      TDD::ABF::Font_Database.get_default_font.line_height
    else
      original_calc_line_height_tdd_abf(text, restore_font_size)
    end
  end
end