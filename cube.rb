# author: Stephan Becque (https://github.com/sjbecque)

class Cube
  attr_reader :x
  attr_reader :y
  attr_reader :value

  def initialize(x, y)
    @x = x
    @y = y
    set_current
  end

  def current?
    @value == :current
  end

  def to_s
    current? ? "x" : "-"
  end

  private

  def set_current
    @value = :current
  end
end