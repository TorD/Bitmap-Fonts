($imported ||= {})["TDD Ace Bitmap Font - Image Font Parser Addon"] = "0.8.0"
#==============================================================================
#
# TDD Ace Bitmap Font - Image Font Parser Addon -- 0.8.0
# _____________________________________________________________________________
#
# + Author:   Galenmereth / Tor Damian Design
# + E-mail:   post@tordamian.com
# -----------------------------------------------------------------------------
# + Last updated: 06/02/2015
# + Level: Easy, Normal
# + Requires: TDD Ace Bitmap Font - Core (0.1.0)
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
# Free for non-commercial use. For commercial use, please contact the author
# at post@tordamian.com to purchase a commercial license; one license is for
# one project. You only need to acquire the license the moment you start
# selling your game, so feel free to try the script out for as long as you want
# until you are satisified and certain about acquiring a license.
# 
# Please credit Tor Damian Design. Only share links to this script provided by
# the author; do not mirror it.
#==============================================================================
module TDD
module ABF
module Image_Font_Parser
module SETTINGS
  FONT_CONFIGS = {# Don't edit this
    "asd" => {
      # ------------------------------------------------------------------------
      # Size
      # ====
      # OPTIONAL: The size of the font, in pixels.
      # Default: Automatically retrieved from the largest letter (without stem)
      #          in the image file.
      # ------------------------------------------------------------------------
      :size       => 36,
      # ------------------------------------------------------------------------
      # Base
      # ====
      # OPTIONAL: The base size of the font, in pixels.
      # Default: Automatically retrieved from the smallest letter (without stem)
      #          in the image file.
      # ------------------------------------------------------------------------
      :base       => 10,
      # ------------------------------------------------------------------------
      # Space
      # =====
      # OPTIONAL: The size of spaces in sentences, in pixels.
      # Default: 10 pixels
      # ------------------------------------------------------------------------
      :space      => 16,         # The width of a space / blank character
      # ------------------------------------------------------------------------
      # Line Height
      # ===========
      # OPTIONAL: Distance between each line of text, in pixels.
      # Default: Automatically retrieved from the largest letter (without stem)
      #          in the image file.
      # ------------------------------------------------------------------------
      :lineHeight => 36,
      # ------------------------------------------------------------------------
      # Padding
      # =======
      # OPTIONAL: Padding of text drawing, as array [top, right, bottom, left]
      #           of pixels.
      # Default: [0, 0, 0, 0]
      # ------------------------------------------------------------------------
      :padding    => [2,2,2,2],
      # ------------------------------------------------------------------------
      # Spacing
      # =======
      # OPTIONAL: Extra letter spacing when drawing, as array [x, y]
      # Default: [0, 0]
      # ------------------------------------------------------------------------
      :spacing    => [0,0],      # Extra letter spacing, x,y
      # ------------------------------------------------------------------------
      # Kerning
      # =======
      # OPTIONAL: Finetune spacing between two letters, as an array and value
      #           ["a", "b"] => -5, where -5 is the amount you want to adjust
      #           letter "b" when displayed after letter "a". In this example,
      #           "b" would be drawn -5 pixels adjusted from "a", meaning 5
      #           pixels closer to "a" than normal.
      # Default:  None
      # ------------------------------------------------------------------------
      :kerning    => {# Do not edit this
      # Add new kerning data; remember to end each line with a comma (,)
      # ["a", "b"] => -5,
        ["i", "j"] => -8,
        ["a", "d"] => +5,
      }# Do not edit this
    }
  }# Don't edit this
end
end
end
end