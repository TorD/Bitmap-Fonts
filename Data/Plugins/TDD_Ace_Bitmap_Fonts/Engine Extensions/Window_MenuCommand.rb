class Window_TitleCommand < Window_Command
  include TDD::ABF::Window_Helpers
  alias_method :original_window_width_tdd_abf, :window_width
  def window_width
    puts "window_width: #{bitmap_window_width}"
    bitmap_window_width || original_window_width_tdd_abf
  end
end