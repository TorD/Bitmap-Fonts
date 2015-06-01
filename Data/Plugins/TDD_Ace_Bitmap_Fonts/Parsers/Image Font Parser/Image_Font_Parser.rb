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
      finalized_char_data.each{|cd| puts "Character #{cd.id.chr} found: x:#{cd.x}, y:#{cd.y}, width:#{cd.width}, height: #{cd.height}, space: #{cd.x_advance}"}
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

    @finalized_char_data
  end

  def info
    {
      :face => font_name,
    }.merge(TDD::ABF::Image_Font_Parser::SETTINGS::FONT_CONFIGS[font_name])
  end

  def kerning
    []
  end

  def get_y_offset(char_data)
    char_data.y - baselines.select{|y| y <= char_data.y}.first
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

  def get_x_advance_for(ox, oy)
    x = 0
    x += 1 while is_valid_char_spacing?(ox + x, oy)
    x
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