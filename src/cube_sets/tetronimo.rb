# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class Tetronimo < CubeSet
    attr_accessor :rotation, :rotation_corrections

    def initialize
      @rotation = 0
    end

    def self.init_cube(*args)
      Cube.current(*args)
    end

    def set_rotation_corrections(corrections)
      @rotation_corrections = corrections
      self
    end

    def rotate(direction)
      each do |cube|
        cube.rotate(origin, direction)
      end

      @rotation += case direction
        when :clockwise then 1
        when :counter_clockwise then -1
      end

      if @rotation_corrections
        move( @rotation_corrections[rotation_index][direction] )
      end

      self
    end

    def move(vector)
      each do |cube|
        cube.x = cube.x + vector[:x]
        cube.y = cube.y + vector[:y]
      end

      self
    end

    def bottom_collision?(height)
      any? { |cube| cube.y >= height }
    end

    def boundary_collision?(width)
      any? { |cube| !(0...width).include?(cube.x) }
    end

    def origin
      @cubes.find{|cube| cube.origin }
    end

    def clone
      tetronimo = super
      tetronimo.rotation = @rotation
      tetronimo.rotation_corrections = @rotation_corrections
      tetronimo
    end

    private

    # reduces the rotation to be within range (0..3),
    # meaning north, east, south, west respectively
    def rotation_index
      @rotation % 4
    end

  end
end