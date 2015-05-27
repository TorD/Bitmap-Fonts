module TDD
module ABF
class Kerning_Data
  def initialize(hash)
    @data = hash
  end

  def first
    @data[:first]
  end

  def second
    @data[:second]
  end

  def amount
    @data[:amount]
  end
end
end
end