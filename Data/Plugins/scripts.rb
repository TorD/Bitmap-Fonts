# encoding: UTF-8
module TDD
module ABF
module SETTINGS
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Font Folder - 
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # This is the folder relative to your project's root folder
  # (where the folders Data, Graphics and System, among others) reside.
  #
  # DEFAULT: "BitmapFonts"
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  FOLDER = "BitmapFonts"

  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Global Default Font - 
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # If you set this to a font name using the format "font name", this will be
  # used globally for all text. You can still override individual message boxes
  # using script calls, and individual sections using the below settings.
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  DEFAULT_FONT = "pixel"

  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Center Vertical -
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # By default, Ace centers all text vertically when drawing. This is also on 
  # here by default, but can be disabled by setting it to false.
  #
  # OPTIONS:
  #   true      (ON)
  #   false     (OFF)
  #
  # DEFAULT: true
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  CENTER_VERTICAL = false

  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Auto Reize Text -
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # By default, Ace tries to fit text that is too long for a given rectangle by
  # scrunching it together. By default this script disables this; you can enable
  # it by setting this to true
  #
  # NOTE: If you want to preserve pixel perfect text, set this to false.
  #
  # OPTIONS:
  #   true      (ON)
  #   false     (OFF)
  # 
  # DEFAULT: false
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  AUTO_RESIZE_TEXT = false

  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Auto Resize Interface -
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # If set to true, command windows and interface elements will be horizontally
  # resized based on the text size of items in them, rather than Ace's fixed
  # default sizes.
  #
  # IMPORTANT: If you use other scripts that affect the size of windows, you
  #            should probably keep this disabled
  #
  # OPTIONS:
  #   true      (ON)
  #   false     (OFF)
  #
  # DEFAULT: false
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  AUTO_RESIZE_INTERFACE = true
end
end
end
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

  def line_height
    @info[:lineHeight]
  end

  def letter_spacing
    @info[:spacing]
  end

  def base
    @info[:base]
  end

  def size=(value)
    
  end

  def bold=(value)
    
  end

  def italic=(value)
    
  end

  def color
    Color.new
  end
end
end
end
module TDD
module ABF
class Char_Data
  def initialize(data_hash)
    @data = data_hash
  end

  def id
    @data[:id]
  end

  def x
    @data[:x]
  end

  def y
    @data[:y]
  end

  def width
    @data[:width]
  end

  def height
    @data[:height]
  end

  def x_offset
    @data[:xoffset]
  end

  def y_offset
    @data[:yoffset]
  end

  def x_advance
    @data[:xadvance]
  end
end
end
end
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
module TDD
module ABF
class Kerning_Data
  def initialize(hash)
    @data = hash
  end

  def first
    @data[:first]
  end

  def second
    @data[:second]
  end

  def amount
    @data[:amount]
  end
end
end
end
#==============================================================================
# ** Module TDD::ABF::Standard_Font_Parser
#------------------------------------------------------------------------------
#  This module is used to parse standard bitmap font XML data files.
#==============================================================================
module TDD
module ABF
module Standard_Font_Parser
  module_function
  #--------------------------------------------------------------------------
  # * Parse font xml
  # = (Hash) Font Info, (Hash) Font Character Data, (Hash) Font Kerning Data, (String) Font File
  #--------------------------------------------------------------------------
  def parse(xml_string)
    return parse_fnt_xml_info(xml_string), parse_fnt_xml_char_data(xml_string), parse_fnt_xml_kerning_data(xml_string), parse_fnt_xml_file(xml_string)
  end
  #--------------------------------------------------------------------------
  # * Parse font xml info area
  # = (Hash)
  #--------------------------------------------------------------------------
  def parse_fnt_xml_info(xml_string)
    info = nil
    xml_string.scan(/<info face="(.*)" size="(.*)" bold="(.*)" italic="(.*)" charset="(.*)" unicode="(.*)" stretchH="(.*)" smooth="(.*)" aa="(.*)" padding="(.*)" spacing="(.*)" outline="(.*)"\/>/) do |m|
      info = {
        :face     => m[0],
        :size     => m[1].to_i,
        :bold     => int_to_bool(m[2]),
        :italic   => int_to_bool(m[3]),
        :charset  => m[4],
        :unicode  => m[5],
        :stretchH => m[6].to_f,
        :smooth   => int_to_bool(m[7]),
        :aa       => int_to_bool(m[8]),
        :padding  => string_list_to_int_list(m[9]),
        :spacing  => string_list_to_int_list(m[10])
      }
    end
    xml_string.scan(/<common lineHeight="(.*)" base="(.*)" scaleW="(.*)" scaleH="(.*)" pages="(.*)" packed="(.*)"\/>/) do |m|
      info = {
        :lineHeight => m[0].to_i,
        :base       => m[1].to_i,
        :scaleW     => m[2].to_i,
        :scaleH     => m[3].to_i,
        :pages      => m[4].to_i,
        :packed     => int_to_bool(m[5])
      }.merge(info)
    end
    info
  end
  #--------------------------------------------------------------------------
  # * Parse font xml character data
  # = (Array) with (Hash) entries for info
  #--------------------------------------------------------------------------
  def parse_fnt_xml_char_data(xml_string)
    result = []
    xml_string.scan(/<char id="(.*)" x="(.*)" y="(.*)" width="(.*)" height="(.*)" xoffset="(.*)" yoffset="(.*)" xadvance="(.*)" page="(.*)" chnl="(.*)"\/>/) do |m|
      result << TDD::ABF::Char_Data.new({
        :id       => m[0].to_i,
        :x        => m[1].to_f,
        :y        => m[2].to_f,
        :width    => m[3].to_f,
        :height   => m[4].to_f,
        :xoffset  => m[5].to_f,
        :yoffset  => m[6].to_f,
        :xadvance => m[7].to_f,
        :page     => m[8].to_f,
        :chnl     => m[9].to_f
      })
    end
    result
  end
  #--------------------------------------------------------------------------
  # * Parse font xml kerning data
  # = (Array) with (Hash) entries for info
  #--------------------------------------------------------------------------
  def parse_fnt_xml_kerning_data(xml_string)
    result = []
    xml_string.scan(/<kerning first="(.*)" second="(.*)" amount="(.*)"\/>/) do |m|
      result << TDD::ABF::Kerning_Data.new({
        :first  => m[0].to_i,
        :second => m[1].to_i,
        :amount => m[2].to_f
      })
    end
    result
  end
  #--------------------------------------------------------------------------
  # * Parse font xml file data
  # = (String) filename.extension
  #--------------------------------------------------------------------------
  def parse_fnt_xml_file(xml_string)
    xml_string.match(/file="(.*)"/)[1]
  end
  #--------------------------------------------------------------------------
  # * Convert int to boolean
  # = "1" => true, "2" => true, "0" => false
  #--------------------------------------------------------------------------
  def int_to_bool(int)
    int.to_i >= 1 ? true : false
  end
  #--------------------------------------------------------------------------
  # * Convert string list to int list
  # = ["1", "2"] => [1, 2]
  #--------------------------------------------------------------------------
  def string_list_to_int_list(string_list)
    string_list.split(",").map{|x| x.to_i}
  end
end
end
end
module TDD
module ABF
module Window_Helpers
  def bitmap_window_width
    return false unless TDD::ABF::SETTINGS::AUTO_RESIZE_INTERFACE
    bitmap = Bitmap.new(1, 1)
    return @list.map{|i| bitmap.bitmap_text_width(i[:name])}.max + 32 if bitmap.bitmap_font?
    return false
  end
end
end
end
# Load all font files
Dir.glob("#{TDD::ABF::SETTINGS::FOLDER}/*.fnt") do |file|
  TDD::ABF::Font_Database.load_font(load_data(file))
end

# Control settings
if TDD::ABF::SETTINGS::DEFAULT_FONT && !TDD::ABF::Font_Database.has_font?(TDD::ABF::SETTINGS::DEFAULT_FONT)
  raise "TDD Ace Bitmap Fonts: Cannot find font face #{TDD::ABF::SETTINGS::DEFAULT_FONT} in folder #{TDD::ABF::SETTINGS::FOLDER}; are you sure it's there?"
end
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
module Cache
  def self.bitmap_font(filename)
    load_bitmap("#{TDD::ABF::SETTINGS::FOLDER}/", filename)
  end
end
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
class Window_TitleCommand < Window_Command
  include TDD::ABF::Window_Helpers
  alias_method :original_window_width_tdd_abf, :window_width
  def window_width
    puts "window_width: #{bitmap_window_width}"
    bitmap_window_width || original_window_width_tdd_abf
  end
end