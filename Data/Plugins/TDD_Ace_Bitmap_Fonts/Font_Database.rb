module TDD
module ABF
module Font_Database
  module_function
  def load_font(font_data_file)
    font = TDD::ABF::Bitmap_Font.new(font_data_file)
    puts "Loading font: #{font.name}"
    fonts[font.name] = font
  end

  def fonts
    @@fonts ||= {}
  end

  def get_font(font_name)
    fonts[font_name]
  end

  def has_font?(font_name)
    fonts.keys.include?(font_name)
  end
end
end
end