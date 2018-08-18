# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class Cube
    attr_accessor :x, :y, :rotation
    attr_reader :value, :origin, :rotation_corrections

    def initialize(x, y, origin = false, rotation_corrections = nil)
      @x = x
      @y = y
      @origin = origin
      @rotation = 0
      @rotation_corrections = rotation_corrections
    end

    def self.current(x, y, origin = false, rotation_corrections = nil)
      instance = new(x, y, origin, rotation_corrections)
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

    def rotation_correction(direction)
      if @rotation_corrections
        vectors = @rotation_corrections[self.rotation_index]

        direction == :clockwise ? vectors.first : vectors.last
      else
        { x: 0, y: 0}
      end
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

    # reduces the rotation to be within range (0..3),
    # meaning north, east, south, west respectively
    def rotation_index
      @rotation % 4
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

    def inspect
      (coordinates + [origin]).to_s
    end

    def set_current
      @value = :current
    end

  end
end
