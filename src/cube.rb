# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class Cube
    attr_accessor :x, :y
    attr_reader :value, :origin

    def initialize(x, y, origin = false)
      @x = x
      @y = y
      @origin = origin
      @rotation = 0
    end

    def self.current(x, y, origin = false)
      instance = new(x, y, origin)
      instance.set_current
      instance
    end

    def self.static(x, y)
      instance = new(x, y)
      instance.stonify
      instance
    end

    def +(other)
      self.class.new(
        self.x + other.x,
        self.y + other.y,
        self.origin
      )
    end

    def ==(other)
      self.coordinates == other.coordinates && self.origin == other.origin
    end

    # of course we could use the Matrix object for this,
    # but lets just do the transformation manually for fun
    def rotate(origin, direction)
      directions = {
        clockwise: 1,
        counter_clockwise: -1
      }

      relative_x = x - origin.x
      relative_y = y - origin.y

      self.x = origin.x - relative_y * directions.fetch(direction)
      self.y = origin.y + relative_x * directions.fetch(direction)

      self
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

    def current?
      @value == :current
    end

    def static?
      @value != :current
    end

    def set_current
      @value = :current
      self
    end

    def stonify
      @value = :red
      self
    end

    def coordinates
      [@x, @y]
    end

    def inspect
      (coordinates + [origin]).to_s
    end

  end
end
