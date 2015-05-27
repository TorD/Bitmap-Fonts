class Bitmap
  alias_method :original_draw_text_tdd_abf_bitmap, :draw_text
  def draw_text(*args)
    if bitmap_font?
      draw_bitmap_text(*args)
    else
      original_draw_text_tdd_abf_bitmap(*args)
    end
  end

  def draw_bitmap_text(*args)
    dim_rect, str, align = parse_draw_text_args(args)
    puts "draw_bitmap_text: #{dim_rect}, #{str}, #{align}"

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

    # Setup y origin
    if TDD::ABF::SETTINGS::CENTER_VERTICAL
      oy = dim_rect.y + (dim_rect.height - font.line_height) / 2
    else
      oy = dim_rect.y
    end

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

  alias_method :original_get_font_tdd_abf_bitmap, :font
  def font
    if TDD::ABF::SETTINGS::DEFAULT_FONT
      return TDD::ABF::Font_Database.get_font(TDD::ABF::SETTINGS::DEFAULT_FONT)
    else
      original_get_font_tdd_abf_bitmap
    end
  end

  def bitmap_font?
    TDD::ABF::Font_Database.has_font?(font.name)
  end

  def parse_draw_text_args(args)
    return args if args.first.is_a? Rect
    return Rect.new(args[0], args[1], args[2], args[3]), args[4], args[5]
  end

  alias_method :original_text_size_tdd_abf_bitmap, :text_size
  def text_size(str)
    if bitmap_font?
      return Rect.new(0, 0, bitmap_text_width(str), font.line_height)
    else
      original_text_size_tdd_abf_bitmap(str)
    end
  end

  def bitmap_text_width(str)
    text_width = 0.0
    last_char = nil
    char_data = nil
    if str.to_s.length > 1
      str.to_s.each_char do |char|
        char_data = font.char_data_for(char)
        next unless char_data
        text_width += font.letter_spacing[0] + char_data.x_offset + char_data.x_advance
        text_width += font.kerning(last_char, char) if last_char
        puts "text_width: #{text_width}"
        last_char = char
      end
      text_width += char_data.width - char_data.x_advance if char_data
    else
      char_data = font.char_data_for(str.to_s)
      text_width += char_data.x_advance if char_data
    end
    puts "bitmap_text_width for #{str} = #{text_width}"
    text_width
  end
end