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