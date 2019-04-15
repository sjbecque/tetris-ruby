# author: Stephan Becque (https://github.com/sjbecque)

class Cube
  attr_accessor :x, :y
  attr_reader :value

  def initialize(x, y)
    @x = x
    @y = y
  end

  def self.current(x, y)
    instance = new(x, y)
    instance.set_current
    instance
  end

  def self.static(x, y)
    instance = new(x, y)
    instance.stonify
    instance
  end

  def current?
    @value == :current
  end

  def static?
    @value != :current
  end

  def stonify
    @value = :red
  end

  def to_s
    case
    when self.current?
      "x"
    else
      if @value
        "o"
      else
        "-"
     end
    end
  end

  def set_current
    @value = :current
  end

end