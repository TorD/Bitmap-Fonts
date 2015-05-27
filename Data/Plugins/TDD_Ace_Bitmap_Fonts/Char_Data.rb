module TDD
module ABF
class Char_Data
  def initialize(data_hash)
    @data = data_hash
  end

  def id
    @data[:id]
  end

  def x
    @data[:x]
  end

  def y
    @data[:y]
  end

  def width
    @data[:width]
  end

  def height
    @data[:height]
  end

  def x_offset
    @data[:xoffset]
  end

  def y_offset
    @data[:yoffset]
  end

  def x_advance
    @data[:xadvance]
  end
end
end
end