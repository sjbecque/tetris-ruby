# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class Cube
    attr_accessor :x, :y, :origin, :rotation
    attr_reader :value

    def initialize(x, y, origin = false)
      @x = x
      @y = y
      @origin = origin
      @rotation = 0
    end

    def self.current(x, y, origin = false, &rotation_correction_block)
      instance = new(x, y, origin)
      instance.define_singleton_method(
        :rotation_correction,
        rotation_correction_block || lambda{|direction| {x:0, y:0}}
      )
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

    def current?
      @value == :current
    end

    def static?
      @value != :current
    end

    def stonify
      @value = :red
    end

    def coordinates
      [@x, @y]
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

    def inspect
      (coordinates + [origin]).to_s
    end

    def set_current
      @value = :current
    end

    # reduces the rotation to range (0..3),
    # meaning north, east, south, west respectively
    def rotation_index
      @rotation % 4
    end
  end
end
