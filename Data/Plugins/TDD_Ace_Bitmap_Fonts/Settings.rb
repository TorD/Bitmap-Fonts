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
  #  "bmf_example" => -10,
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

  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # - End Of Configuration -
  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
end
end
end