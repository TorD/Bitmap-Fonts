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
    #finalized_char_data.each{|cd| puts "Character #{cd.id.chr} found: x:#{cd.x}, y:#{cd.y}, x_offset:#{cd.x_offset}, y_offset:#{cd.y_offset}, width:#{cd.width}, height: #{cd.height}, space: #{cd.x_advance}"}
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

  def line_starts
    @line_starts ||= baselines.map do |bl|
      bl - max_height
    end
  end

  def char_heights
    char_data.map do |cd| # Char height with baseline subtracted
      bl = baselines.select{|b| cd.yr.include?(b)}.first
      next unless bl
      cd.height - ((cd.height + cd.y) - bl) # Subtract char below baseline
    end.compact
  end

  def max_height
    char_heights.max
  end

  def min_height
    char_heights.min
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
    baselines.each do |bl|
      row_data = char_data.select{|cd| cd.yr.include?(bl)}
      row_data.sort_by!{|rd| rd.x}.each do |cd|
        @finalized_char_data << cd
      end
    end

    @finalized_char_data.each_with_index.map do |cd, n|
      char = get_character_at(n)
      next unless char
      cd.id = char.ord
      cd.x_offset ||= 0
      cd.y_offset ||= get_y_offset(cd)
      cd
    end.compact.reject!{|cd| cd.id.nil?}

    @finalized_char_data << space_char

    @finalized_char_data
  end

  def info
    settings
  end

  def settings
    default_settings.merge(TDD::ABF::Image_Font_Parser::SETTINGS::FONT_CONFIGS[font_name] || {})
  end

  def default_settings
    {
      :face       => font_name,
      :lineHeight => max_height,
      :base       => min_height,
      :padding    => [0,0,0,0],
      :size       => max_height,
      :spacing    => [0,0],
      :kerning    => {}
    }
  end

  def kerning
    kerning = settings[:kerning]
    return [] unless kerning
    kerning.map do |kern_chars, value|
      Kerning_Data.new({
        :first  => kern_chars.first.ord,
        :second => kern_chars.last.ord,
        :amount => value
      })
    end
  end

  def get_y_offset(char_data)
    char_data.y - line_starts.select{|y| y <= char_data.y}.last
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
    
    # Get x_advance and x_offset
    data.x_advance = 0.0
    data.x_offset = 0.0
    data.width.times do |n|
      x = ox + 1 + n
      y = oy + data.height + 1
      if is_valid_char_spacing?(x, y)
        data.x_advance += 1
      elsif is_valid_char_outline?(x, y) && data.x_advance == 0
        data.x_offset -= 1
      end
    end
    data.x_offset = 0 if data.x_advance == 0
    data.x_advance += data.x_offset.abs
    data.x_advance = data.width if data.x_advance <= 1

    # Dimensional range data
    data.xr = ox..(ox + data.width + 1)
    data.yr = oy..(oy + data.height + 1)

    # Return data
    data
  end

  def space_char
    data = TDD::ABF::Char_Data.new
    data.x = data.y = 0

    data.height = 0
    data.width = space_size

    data.x_advance = space_size
    data.x_offset = data.y_offset = 0
    data.id = 32

    data
  end

  def space_size
    settings[:space] || 10
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
    settings[:character_map] || default_characer_map
  end

  def characters_per_row
    settings[:per_row] || default_characer_map
  end

  def default_characters_per_row
    if character_map.first.is_a? Array
      character_map.first.size
    else
      character_map.size
    end
  end

  def get_character_at(index)
    if character_map.first.is_a? Array
      total = 0
      character_map.map do |row|
        total += row.size
        row[index - total] if total > index
      end.compact.first
    else
      character_map[index]
    end
  end

  def default_characer_map
    %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z]
  end
end
end
end
end