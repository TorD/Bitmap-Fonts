# Load all font files
Dir.glob("#{TDD::ABF::SETTINGS::FOLDER}/*.fnt") do |file|
  TDD::ABF::Font_Database.load_font(load_data(file))
end

# Control settings
if TDD::ABF::SETTINGS::DEFAULT_FONT && !TDD::ABF::Font_Database.has_font?(TDD::ABF::SETTINGS::DEFAULT_FONT)
  raise "TDD Ace Bitmap Fonts: Cannot find font face #{TDD::ABF::SETTINGS::DEFAULT_FONT} in folder #{TDD::ABF::SETTINGS::FOLDER}; are you sure it's there?"
end