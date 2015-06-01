# encoding: UTF-8
#==============================================================================
#
# TDD Ace Bitmap Font - 0.1.0
# _____________________________________________________________________________
#
# + Author:   Galenmereth / Tor Damian Design
# + E-mail:   post@tordamian.com
# -----------------------------------------------------------------------------
# + Last updated: 05/29/2015
# + Level: Easy, Normal
# + Requires: n/a
# _____________________________________________________________________________
#
# ▼ Changelog
# -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
# 0.1.0   Fixed spacing bug for single characters, reorganized parser system to
#         support the new optional Image Font Parser.
#
# 0.0.8   Added ADJUST_HORIZONTAL_DRAW_POSITION setting.
#
# 0.0.7   Added ADJUST_VERTICAL_DRAW_POSITION setting.
#
# 0.0.6   Fixed line height bugs and added OVERRIDE_LINE_HEIGHT setting.
#
# 0.0.5   Core functionality of rendering bitmap fonts based on the standardized 
#         bitmap font format implemented.
#
#==============================================================================
# ▼ Information
# -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
# By default, this script will support a pretty standard format of bitmap
# fonts, where you require a .fnt file that is structured in a certain way,
# and a graphic file in any format Ace supports.
#
#==============================================================================
# ▼ Important
# -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
# Bitmap fonts will ignore text codes that attempt to change their color, size,
# outline, shadow, and other properties: if you need these features, you should
# use regular fonts for these areas. Bitmap fonts provide great flexibility in
# decorations and pixel perfect rendering, but they are not a replacement for
# standard font files, but are rather an alternative with their own pros and 
# cons.
#
#==============================================================================
# ▼ How to use
# -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
# There are multiple tools out there for making bitmap font files, but the
# following website has a great tool that is absolutely free:
# http://kvazars.com/littera/
# 
# Make sure that you select "XML (.fnt)" in the "Format" dropdown menu, and
# that you give it the name you want for the font in the "Name" box.
#
# To download your font, click Export > Start > Download file. Just ignore
# the settings dialogue in between.
#
# Your browser should then download a .zip file with your font; copy both
# files into your designated (default "BitmapFonts") bitmap font folder in
# your project. The script will find them by itself.
# 
# Then set this font in one of the config areas below (either as the global
# default font, or for a specific section) by setting the respective variables
# to the name you chose for your font.
#
#==============================================================================
# ▼ Installation
# -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
# To install this script, open up your script editor and copy/paste this script
# to an open slot below ▼ Materials/素材 but above ▼ Main. Remember to save.
#
#==============================================================================
# ▼ Thanks and credits
# -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
# # Testers:
#   * Sharm
#   * Vexed
#
#==============================================================================
# ▼ License
# -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
# Free for non-commercial and commercial use. Please credit Tor Damian Design.
# You are free to share script freely with everyone, but please retain this
# description and license. Thank you.
#==============================================================================
module TDD
module ABF
module SETTINGS
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Debug Mode - 
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # If enabled, will print information for debugging in the console, like which
  # fonts get loaded and with what font name. Useful if you're not sure what
  # name to use when setting fonts below.
  #
  # OPTIONS:
  #   true      (ON)
  #   false     (OFF)
  #
  # DEFAULT: false
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  DEBUG_MODE = true

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
  # OPTIONS:
  #   "name of font"  (ON, using named font)
  #   false           (OFF)
  #
  # DEFAULT: false    (OFF)
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  DEFAULT_FONT = "bmf_example"

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
  CENTER_VERTICAL = true

  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Auto Reize Text - NOT YET DONE
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
  # - Auto Resize Interface - NOT YET DONE
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
  AUTO_RESIZE_INTERFACE = false

  #!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
  # - Advanced Settings Below -
  #!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!

  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Override Line Height -
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # This lets you override the line height for each individual font. You can
  # also adjust lineHeight= in the .fnt file, but this can be more convenient.
  #
  # FORMAT:
  #   "font name" => 20,     (20 being the desired line height)
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  OVERRIDE_LINE_HEIGHT = {# Don't edit this
  # Add new overrides below; remember to end each line with a comma (,)
    "POPit" => 23,
  # "example" => 15,
  #
  }# Don't edit this

  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Adjust Vertical Draw Position -
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # Sometimes the letters won't get drawn as you'd like them to, and this
  # setting lets you add a modifier to the vertical drawing position of letters
  # for each font. The adjustment amount can be positive (5) and negative (-5).
  # This setting is different from the override to line height in that it only
  # affects the drawing position of the letters, not the actual dimensions or
  # size.
  #
  # FORMAT:
  #   "font name" => 5,    (5 being the desired adjustment to vertical position)
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  ADJUST_VERTICAL_DRAW_POSITION = {# Don't edit this
  # Add new adjustments below; remember to end each line with a comma (,)
    "POPit"     => 4,
  # "font name" => 5,
  }# Don't edit this

  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Adjust Horizontal Draw Position -
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # Sometimes the letters won't get drawn as you'd like them to, and this
  # setting lets you add a modifier to the start horizontal drawing position of
  # letters for each font. Adjustment can be positive (5) or negative (-5).
  #
  # FORMAT:
  #   "font name" => 5,  (5 being the desired adjustment to horizontal position)
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  ADJUST_HORIZONTAL_DRAW_POSITION = {# Don't edit this
  # Add new adjustments below; remember to end each line with a comma (,)
    "POPit"     => 3,
  # "font name" => 5,
  }# Don't edit this

  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # - Font File Parser - NOT YET DONE
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  # The parser to use for font files. More parsers might be added later by me,
  # you or other scripters; this facilitates an easier way of enabling them.
  #
  # OPTIONS:
  #   :default  (standard bitmap font .fnt files with an XML document structure)
  #-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
  FONT_FILE_PARSER = :default

  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # - End Of Configuration -
  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
  def initialize(font_data, parser)
    parser ||= TDD::ABF::Standard_Font_Parser
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
  def calc_size
    (sizes.inject(:+).to_f / sizes.size) + padding[0]
  end
  def sizes
    [base, size, @info[:lineHeight]]
  end
  def padding
    @info[:padding]
  end
  def horizontal_adjustment
    TDD::ABF::SETTINGS::ADJUST_HORIZONTAL_DRAW_POSITION[name] || 0
  end
  def vertical_adjustment
    TDD::ABF::SETTINGS::ADJUST_VERTICAL_DRAW_POSITION[name] || 0
  end
  #--------------------------------------------------------------------------
  # * Check if bold
  # = (Boolean)
  #--------------------------------------------------------------------------
  def bold
    @info[:bold]
  end
  #--------------------------------------------------------------------------
  # * Check if italic
  # = (Boolean)
  #--------------------------------------------------------------------------
  def italic
    @info[:italic]
  end
  #--------------------------------------------------------------------------
  # * Get line height
  # = (Integer)
  #--------------------------------------------------------------------------
  def line_height
    TDD::ABF::SETTINGS::OVERRIDE_LINE_HEIGHT[name] || @info[:lineHeight]
  end
  #--------------------------------------------------------------------------
  # * Get letter spacing
  # = [x, y] (Array)
  #--------------------------------------------------------------------------
  def letter_spacing
    @info[:spacing]
  end
  #--------------------------------------------------------------------------
  # * Get base of font
  # = (Integer)
  #--------------------------------------------------------------------------
  def base
    @info[:base]
  end
  #--------------------------------------------------------------------------
  # * Get blank color object, for compatibility
  # = (Color)
  #--------------------------------------------------------------------------
  def color
    Color.new
  end
  #--------------------------------------------------------------------------
  # * Setters without function, for compatibility
  #--------------------------------------------------------------------------
  def name=(value); end
  def size=(value); end
  def bold=(value); end
  def italic=(value); end
  def outline=(value); end
  def out_color=(value); end
  def shadow=(value); end
end
end
end
#==============================================================================
# ** Module TDD::ABF::Char_Data
#------------------------------------------------------------------------------
# This class acts as an accessor and instance of individual character data
# entries.
#==============================================================================
module TDD
module ABF
class Char_Data
  attr_accessor :id
  attr_accessor :x
  attr_accessor :y
  attr_accessor :xr         # X range, for image based parsers
  attr_accessor :yr         # Y range, for image based parsers
  attr_accessor :width
  attr_accessor :height
  attr_accessor :x_offset
  attr_accessor :y_offset
  attr_accessor :x_advance
  #--------------------------------------------------------------------------
  # * Initializer
  # > data_hash: Expects a standardized bitmap font data hash. See
  #              TDD::ABF::Standard_Font_Parser
  #--------------------------------------------------------------------------
  def initialize(data_hash={})
    data_hash.each do |key, val|
      instance_variable_set("@#{key}", val)
    end
  end
end
end
end
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
#==============================================================================
# ** Module TDD::ABF::Kerning_Data
#------------------------------------------------------------------------------
# This class acts as an accessor and instance of individual kerning data
# entries.
#==============================================================================
module TDD
module ABF
class Kerning_Data
  def initialize(hash)
    @data = hash
  end
  #--------------------------------------------------------------------------
  # * Get first character code
  #--------------------------------------------------------------------------
  def first
    @data[:first]
  end
  #--------------------------------------------------------------------------
  # * Get second character code
  #--------------------------------------------------------------------------
  def second
    @data[:second]
  end
  #--------------------------------------------------------------------------
  # * Get amount to kern
  #--------------------------------------------------------------------------
  def amount
    @data[:amount]
  end
end
end
end
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
module Cache
  #--------------------------------------------------------------------------
  # * Get Bitmap Font
  #--------------------------------------------------------------------------
  def self.bitmap_font(filename)
    load_bitmap("#{TDD::ABF::SETTINGS::FOLDER}/", filename)
  end
end
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
class Window_TitleCommand < Window_Command
  include TDD::ABF::Window_Helpers
  #--------------------------------------------------------------------------
  # * EXTENDED Window Width
  #--------------------------------------------------------------------------
  alias_method :original_window_width_tdd_abf, :window_width
  def window_width
    bitmap_font_window_width || original_window_width_tdd_abf
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
  def parse(file)
    xml_string = open(file, "r").read.to_s
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
        :id        => m[0].to_i,
        :x         => m[1].to_f,
        :y         => m[2].to_f,
        :width     => m[3].to_f,
        :height    => m[4].to_f,
        :x_offset  => m[5].to_f,
        :y_offset  => m[6].to_f,
        :x_advance => m[7].to_f,
        :page      => m[8].to_f,
        :chnl      => m[9].to_f
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
#==============================================================================
# ** TDD::ABF::Standard Font Parser - Load and process
#------------------------------------------------------------------------------
#  Load and process all font files at compile
#==============================================================================
if TDD::ABF::SETTINGS::DEBUG_MODE
  puts "==========================================="
  puts "TDD Ace Bitmap Fonts - Standard .fnt Parser"
  puts "==========================================="
end

# Load all font files
Dir.glob("#{TDD::ABF::SETTINGS::FOLDER}/*.fnt") do |file|
  font = TDD::ABF::Font_Database.load_font(file)
  #font = TDD::ABF::Font_Database.load_font(load_data(file))
  puts "> Loading font \"#{font.name}\" (#{file})" if TDD::ABF::SETTINGS::DEBUG_MODE
end
module TDD
module ABF
module Image_Font_Parser
module SETTINGS
  FONT_CONFIGS = {# Don't edit this
    "bmf_example" => {
      :size       => 36,         # The font size
      :base       => 20,         # The base of the font
      :space      => 16,         # The width of a space / blank character
      :lineHeight => 20,         # Distance between each line
      :padding    => [2,2,2,2],  # Padding top, right, bottom, left
      :spacing    => [0,0],      # Extra letter spacing, x,y
      :kerning    => {
        ["i", "j"] => -8
      }
    }
  }# Don't edit this
end
end
end
end
module TDD
module ABF
module Image_Font_Parser
class Parser
  StoredDim = Struct.new :xr, :yr

  def self.parse(font_image)
    p = self.new(font_image)
    return p.info, p.finalized_char_data, p.kerning, p.filename
  end

  def initialize(font_image)
    @font_image = font_image
    if TDD::ABF::SETTINGS::DEBUG_MODE
      finalized_char_data.each{|cd| puts "Character #{cd.id.chr} found: x:#{cd.x}, y:#{cd.y}, y_offset:#{cd.y_offset}, width:#{cd.width}, height: #{cd.height}, space: #{cd.x_advance}"}
    end
  end

  def filename
    File.basename(font_image)
  end

  def font_name
    File.basename(font_image.gsub(".bft", ""), ".*")
  end

  def bitmap
    @bitmap ||= Cache.load_bitmap('', font_image)
  end

  def font_image
    @font_image
  end

  def baselines
    @baselines ||= bitmap.height.times.map do |y|
      next if y < 1 # Config pixels
      y if is_baseline?(0, y)
    end.compact
  end

  def line_starts
    return @line_starts if @line_starts
    max_height = char_data.map do |cd| # Char height with baseline subtracted
      bl = baselines.select{|b| cd.yr.include?(b)}.first
      cd.height - ((cd.height + cd.y) - bl) # Subtract char below baseline
    end.max
    baselines.map do |bl|
      bl - max_height
    end
  end

  def char_data
    return @char_data if @char_data

    @char_data = []
    bitmap.width.times do |x|
      bitmap.height.times do |y|
        next if x < 3 && y == 0 # First three pixels are configuration pixels
        @char_data << parse_char(x, y) if is_valid_char_outline?(x, y) && !already_stored?(x, y)
      end
    end

    @char_data
  end

  def finalized_char_data
    return @finalized_char_data if @finalized_char_data
    @finalized_char_data = []
    char_data.dup.sort_by!{|cd| cd.y + cd.height}.each_slice(characters_per_row) do |row_data|
      row_data.sort_by!{|rd| rd.x}.each do |rd|
        @finalized_char_data << rd
      end
    end

    @finalized_char_data.each_with_index.map do |cd, n|
      char = get_character_at(n)
      next unless char
      cd.id = char.ord
      cd.x_offset = 0
      cd.y_offset = get_y_offset(cd)
      cd
    end.compact.reject!{|cd| cd.id.nil?}

    @finalized_char_data << space_char

    @finalized_char_data
  end

  def info
    {
      :face => font_name,
    }.merge(settings)
  end

  def settings
    TDD::ABF::Image_Font_Parser::SETTINGS::FONT_CONFIGS[font_name]
  end

  def kerning
    kerning = settings[:kerning]
    return [] unless kerning
    kerning.map do |kern_chars, value|
      Kerning_Data.new({
        :first  => kern_chars.first.ord,
        :second => kern_chars.last.ord,
        :amount => value
      })
    end
  end

  def get_y_offset(char_data)
    puts "get_y_offset: #{line_starts.select{|y| y <= char_data.y}.last}"
    char_data.y - line_starts.select{|y| y <= char_data.y}.last
  end

  def is_valid_char_outline?(x, y)
    bitmap.get_pixel(x, y) === char_dimensions_color
  end

  def is_valid_char_spacing?(x, y)
    bitmap.get_pixel(x, y) === char_x_advance_color
  end

  def is_baseline?(x, y)
    bitmap.get_pixel(x, y) === char_baseline_color
  end

  def already_stored?(x, y)
    # Now we check if coordinate is already stored
    char_data.select do |ds|
      ds.xr.include?(x) && ds.yr.include?(y)
    end.any?
  end

  # Starts at top left of a character
  def parse_char(ox, oy)
    data = TDD::ABF::Char_Data.new
    data.x = ox + 1 # +1 to ignore first pixel
    data.y = oy + 1 # ^

    # Local vars store
    x = y = 0

    # Get height
    data.height = 0
    data.height += 1 while is_valid_char_outline?(ox, oy + data.height)
    data.height -= 2 # Like width

    # Get width
    data.width = 0
    data.width += 1 while is_valid_char_outline?(ox + data.width, oy)
    data.width -= 2 # We ignore the first and last pixel as that's the outline
    
    # Get x_advance
    data.x_advance = 0
    data.x_advance += 1 while is_valid_char_spacing?(ox + 1 + data.x_advance, oy + data.height + 1)
    data.x_advance = data.width if data.x_advance <= 1

    # Dimensional range data
    data.xr = ox..(ox + data.width + 1)
    data.yr = oy..(oy + data.height + 1)

    # Return data
    data
  end

  def space_char
    data = TDD::ABF::Char_Data.new
    data.x = -1
    data.y = -1

    data.height = 0
    data.width = space_size

    data.x_advance = space_size
    data.x_offset = data.y_offset = 0
    data.id = 32

    data
  end

  def space_size
    settings[:space] || 10
  end

  def char_dimensions_color
    @char_dimensions_color ||= bitmap.get_pixel(0,0)
  end

  def char_x_advance_color
    @char_x_advance_color ||= bitmap.get_pixel(1,0)
  end

  def char_baseline_color
    @char_baseline_color ||= bitmap.get_pixel(2,0)
  end

  def character_map
    default_characer_map
  end

  def characters_per_row
    character_map.first.size
  end

  def get_character_at(index)
    row_data = character_map[index / characters_per_row]
    return nil unless row_data
    return row_data[index % characters_per_row]
  end

  def default_characer_map
    [
      %w[a b c d e f g],
      %w[h i j k l m n],
    ]
  end
end
end
end
end
#==============================================================================
# ** TDD::ABF::Image Font Parser - Load and process
#------------------------------------------------------------------------------
#  Load and process all font files at compile
#==============================================================================
if TDD::ABF::SETTINGS::DEBUG_MODE
  puts "================================================="
  puts "TDD Ace Bitmap Fonts - Image Font .bft.png Parser"
  puts "================================================="
end

# Load all font files
Dir.glob("#{TDD::ABF::SETTINGS::FOLDER}/*.bft.{jpg,png,bmp}") do |file|
  puts "> Reading bft file: \"#{file}\" | Please wait..." if TDD::ABF::SETTINGS::DEBUG_MODE
  font = TDD::ABF::Font_Database.load_font(file, TDD::ABF::Image_Font_Parser::Parser)
  puts ">> Font loaded as: \"#{font.name}\"" if TDD::ABF::SETTINGS::DEBUG_MODE
end
# Control settings
if TDD::ABF::SETTINGS::DEFAULT_FONT && !TDD::ABF::Font_Database.has_font?(TDD::ABF::SETTINGS::DEFAULT_FONT)
  raise "TDD Ace Bitmap Fonts: Cannot find font face #{TDD::ABF::SETTINGS::DEFAULT_FONT} in folder #{TDD::ABF::SETTINGS::FOLDER}; are you sure it's there?"
end
