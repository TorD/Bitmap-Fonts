module TDD
module ABF
module Image_Font_Parser
  module_function
  StoredDim = Struct.new :xr, :yr

  def parse(font_image)
    bitmap = Cache.load_bitmap('', font_image)
    set_vars(bitmap)
    parse_line_starts(bitmap)
    parse_bitmap(bitmap)
    #@@char_data.each{|cd| puts "Character #{cd.id.chr}: x:#{cd.x}, y:#{cd.y}, width:#{cd.width}, height: #{cd.height}, space: #{cd.x_advance}"}
    return info(font_image), parse_char_data, kerning, File.basename(font_image)
  end

  def parse_line_starts(bitmap)
    bitmap.height.times do |y|
      next if y < 1 # Config pixels
      @@line_starts << y if is_line_start?(0, y, bitmap)
    end
  end

  def parse_bitmap(bitmap)
    bitmap.width.times do |x|
      bitmap.height.times do |y|
        next if x < 3 && y == 0 # First three pixels are configuration pixels
        store_dimension_data(x, y, bitmap) if is_valid_char_outline?(x, y, bitmap) && !already_stored?(x, y)
      end
    end
  end

  def info(font_image)
    font_name = File.basename(font_image.gsub(".bft", ""), ".*")
    {
      :face => font_name,
    }.merge(TDD::ABF::Image_Font_Parser::SETTINGS::FONT_CONFIGS[font_name])
  end

  def kerning
    []
  end

  # Parses the char data file
  def parse_char_data
    sorted_char_data = []
    @@char_data.sort_by!{|cd| cd.y + cd.height}.each_slice(characters_per_row) do |row_data|
      row_data.sort_by!{|rd| rd.x}.each do |rd|
        sorted_char_data << rd
      end
    end
    @@char_data = sorted_char_data

    @@char_data.each_with_index.map do |cd, n|
      cd.id = get_character_at(n).ord
      cd.x_offset = 0
      cd.y_offset = get_y_offset(cd)
    end

    @@char_data
  end

  def get_y_offset(char_data)
    char_data.y - @@line_starts.select{|y| y <= char_data.y}.first
  end

  def is_valid_char_outline?(x, y, bitmap)
    bitmap.get_pixel(x, y) === @@char_dimensions_color
  end

  def is_valid_char_spacing?(x, y, bitmap)
    bitmap.get_pixel(x, y) === @@char_x_advance_color
  end

  def is_line_start?(x, y, bitmap)
    bitmap.get_pixel(x, y) === @@char_line_start_color
  end

  def already_stored?(x, y)
    # Now we check if coordinate is already stored
    @@stored_control_data.select do |sd|
      sd.xr.include?(x) && sd.yr.include?(y)
    end.any?
  end

  # Starts at top left of a character
  def store_dimension_data(ox, oy, bitmap)
    data = (@@char_data << TDD::ABF::Char_Data.new).last
    data.x = ox + 1 # +1 to ignore first pixel
    data.y = oy + 1 # ^

    # Local vars store
    x = y = 0

    # Get width
    x += 1 while is_valid_char_outline?(ox + x, oy, bitmap)
    data.width = x - 2 # We ignore the first and last pixel as that's the outline
    data.x_advance = data.width + get_x_advance_for(ox + x, oy, bitmap)

    # Get height
    y += 1 while is_valid_char_outline?(ox, oy + y, bitmap)
    data.height = y - 2 # Like width

    store = (@@stored_control_data << StoredDim.new).last
    store.xr = ox..(ox + data.width + 1)
    store.yr = oy..(oy + data.height + 1)
  end

  def get_x_advance_for(ox, oy, bitmap)
    x = 0
    x += 1 while is_valid_char_spacing?(ox + x, oy, bitmap)
    x
  end

  def set_vars(bitmap)
    @@char_dimensions_color = bitmap.get_pixel(0,0)
    @@char_x_advance_color  = bitmap.get_pixel(1,0)
    @@char_line_start_color = bitmap.get_pixel(2,0)
    @@char_data             = []
    @@line_starts           = []
    @@stored_control_data   = []
  end

  def character_map
    default_characer_map
  end

  def characters_per_row
    character_map.first.size
  end

  def get_character_at(index)
    character_map[index / characters_per_row][index % characters_per_row]
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