class Window_Base
  # NEW
  def bitmap_window_width
    if !disposed?
      puts "window_width: #{contents.bitmap_font?}"
      @list.map{|i| contents.bitmap_text_width(i[:name])}.max
    else
      original_window_width_tdd_abf_window_command
    end
  end
end