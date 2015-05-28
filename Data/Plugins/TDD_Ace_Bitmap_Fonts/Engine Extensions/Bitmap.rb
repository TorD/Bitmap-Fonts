class Bitmap
  include TDD::ABF::General_Helper
  #--------------------------------------------------------------------------
  # * EXTEND Draw Text
  #--------------------------------------------------------------------------
  alias_method :original_draw_text_tdd_abf_bitmap, :draw_text
  def draw_text(*args)
    if bitmap_font?
      draw_bitmap_text(*args)
    else
      original_draw_text_tdd_abf_bitmap(*args)
    end
  end
  #--------------------------------------------------------------------------
  # * NEW Draw Bitmap Text
  #--------------------------------------------------------------------------
  def draw_bitmap_text(*args)
    # Parse args
    dim_rect, str, align = parse_draw_text_args(args)

    # Create src rect for bitmap blt
    src_rect = Rect.new

    # Setup x and y origin
    align ||= 0
    case align
    when 0
      x = dim_rect.x
    when 1
      x = dim_rect.x + ((dim_rect.width - bitmap_text_width(str)) / 2)
    when 2
      x = (dim_rect.x + dim_rect.width) - bitmap_text_width(str)
    end
    x += font.horizontal_adjustment

    # Setup y origin
    oy = dim_rect.y
    oy += ((dim_rect.height - font.calc_size) / 2) if TDD::ABF::SETTINGS::CENTER_VERTICAL
    oy += font.vertical_adjustment

    # Make last char local var for keeping
    last_char = nil

    # Draw each character
    str.to_s.each_char do |char|
      # Get char data
      char_data = font.char_data_for(char)
      next unless char_data 

      # Setup
      src_rect.set(char_data.x, char_data.y, char_data.width, char_data.height)
      y = oy
      y += char_data.y_offset + font.letter_spacing[1]
      x += font.letter_spacing[0] + char_data.x_offset
      x += font.kerning(last_char, char) if last_char

      # Draw
      blt(x, y, Cache.bitmap_font(font.file), src_rect)

      # Increase x
      x += char_data.x_advance
      last_char = char
    end
  end
  #--------------------------------------------------------------------------
  # * EXTEND Get font
  #--------------------------------------------------------------------------
  alias_method :original_get_font_tdd_abf_bitmap, :font
  def font
    if bitmap_font?
      return TDD::ABF::Font_Database.get_default_font
    else
      original_get_font_tdd_abf_bitmap
    end
  end
  #--------------------------------------------------------------------------
  # * NEW Check if using Bitmap Font?
  #--------------------------------------------------------------------------
  def bitmap_font?
    TDD::ABF::Font_Database.default_is_bitmap?
  end
  #--------------------------------------------------------------------------
  # * NEW Parse draw_text args
  #--------------------------------------------------------------------------
  def parse_draw_text_args(args)
    return args if args.first.is_a? Rect
    return Rect.new(args[0], args[1], args[2], args[3]), args[4], args[5]
  end
  #--------------------------------------------------------------------------
  # * EXTEND Text size
  #--------------------------------------------------------------------------
  alias_method :original_text_size_tdd_abf_bitmap, :text_size
  def text_size(str)
    if bitmap_font?
      return Rect.new(0, 0, bitmap_text_width(str), font.line_height)
    else
      original_text_size_tdd_abf_bitmap(str)
    end
  end
  #--------------------------------------------------------------------------
  # * NEW Get bitmap text width
  #--------------------------------------------------------------------------
  def bitmap_text_width(str)
    calculate_text_width(str, font)
  end
end