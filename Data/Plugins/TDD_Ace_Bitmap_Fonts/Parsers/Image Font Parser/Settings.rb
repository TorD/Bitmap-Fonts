module TDD
module ABF
module Image_Font_Parser
module SETTINGS
  FONT_CONFIGS = {# Don't edit this
    "bmf_example" => {
      :per_row => 7,
    },
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
      #           letter "b" when rendered after letter "a". In this example,
      #           "b" would be drawn -5 pixels adjusted from "a", meaning 5
      #           pixels closer than other letters.
      # Default:  None
      # ------------------------------------------------------------------------
      :kerning    => {# Do not edit this
      # Add new ; remember to end each line with a comma (,)
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