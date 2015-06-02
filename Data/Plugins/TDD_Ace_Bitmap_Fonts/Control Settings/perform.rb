module TDD
module ABF
module USER_ASSISTANCE
  module_function
  def perform
    check_default_font
  end
  def check_default_font
    if TDD::ABF::SETTINGS::DEFAULT_FONT && !TDD::ABF::Font_Database.has_font?(TDD::ABF::SETTINGS::DEFAULT_FONT)
      #raise "TDD Ace Bitmap Fonts: Cannot find font face #{TDD::ABF::SETTINGS::DEFAULT_FONT} in folder #{TDD::ABF::SETTINGS::FOLDER}; are you sure it's there? \nBe sure to verify the font face name."
      raise font_not_found_error(TDD::ABF::SETTINGS::DEFAULT_FONT)
    end
  end
  def debug_mode_hint
    TDD::ABF::SETTINGS::DEBUG_MODE ? "• Please look in the console for a list of all loaded fonts and their font face names." : "• Enable debug mode: To see a list of all fonts loaded by the script, as well as their font face names, set \"DEBUG_MODE = true\" in the script settings."
  end
  def font_not_found_error(font_not_found)
    ["TDD Ace Bitmap Fonts -- Troubleshooting",
    "=======================================",
    "• Cannot find font face \"#{TDD::ABF::SETTINGS::DEFAULT_FONT}\" in font folder \"#{TDD::ABF::SETTINGS::FOLDER}\"; #{font_there_question(font_not_found)}",
    "• Please verify that the font face name \"#{TDD::ABF::SETTINGS::DEFAULT_FONT}\" is correct.",
    debug_mode_hint].join("\n")
  end
  def font_there_question(font_name)
    matches = lazy_match_font(font_name)
    if matches.any?
      "did you mean \"#{matches.join(", ")}\"?"
    else
      "are you sure it's there?"
    end
  end
  def lazy_match_font(font_name)
    TDD::ABF::Font_Database.fonts.values.select{|f| (f.name.include?(font_name) || font_name.include?(f.name))}.map{|f| f.name}
  end
end
end
end
TDD::ABF::USER_ASSISTANCE.perform
