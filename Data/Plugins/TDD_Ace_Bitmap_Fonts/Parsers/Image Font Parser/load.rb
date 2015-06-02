#==============================================================================
# ** TDD::ABF::Image Font Parser - Load and process
#------------------------------------------------------------------------------
#  Load and process all font files at compile
#==============================================================================
if TDD::ABF::SETTINGS::DEBUG_MODE
  puts "============================================="
  puts "TDD Ace Bitmap Fonts - Image Font .tbf Parser"
  puts "============================================="
end

# Load all font files
Dir.glob("#{TDD::ABF::SETTINGS::FOLDER}/*.tbf.{jpg,png,bmp}") do |file|
  puts "> Reading tbf file \"#{file}\" | Please wait..." if TDD::ABF::SETTINGS::DEBUG_MODE
  font = TDD::ABF::Font_Database.load_font(file, TDD::ABF::Image_Font_Parser::Parser)
  puts ">> Font loaded as \"#{font.name}\"" if TDD::ABF::SETTINGS::DEBUG_MODE
end