#==============================================================================
# ** TDD::ABF - Load and process
#------------------------------------------------------------------------------
#  Load and process all font files at compile
#==============================================================================
if TDD::ABF::SETTINGS::DEBUG_MODE
  puts "================================="
  puts "TDD Ace Bitmap Fonts - Debug info"
  puts "================================="
end

# Load all font files
Dir.glob("#{TDD::ABF::SETTINGS::FOLDER}/*.fnt") do |file|
  font = TDD::ABF::Font_Database.load_font(open(file, "r").read.to_s)
  #font = TDD::ABF::Font_Database.load_font(load_data(file))
  puts "> Loading font \"#{font.name}\" (#{file})" if TDD::ABF::SETTINGS::DEBUG_MODE
  puts "Data: #{font.line_height}"
end

# Control settings
if TDD::ABF::SETTINGS::DEFAULT_FONT && !TDD::ABF::Font_Database.has_font?(TDD::ABF::SETTINGS::DEFAULT_FONT)
  raise "TDD Ace Bitmap Fonts: Cannot find font face #{TDD::ABF::SETTINGS::DEFAULT_FONT} in folder #{TDD::ABF::SETTINGS::FOLDER}; are you sure it's there?"
end