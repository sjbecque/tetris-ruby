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

      rotation_increment = case direction
        when :clockwise then 1
        when :counter_clockwise then -1
      end

      @rotation += rotation_increment

      move( rotation_correction(direction) )
    end

    def rotation_correction(direction)
      if @rotation_corrections
        vectors = @rotation_corrections[rotation_index]

        direction == :clockwise ? vectors.first : vectors.last
      else
        { x: 0, y: 0 }
      end
    end

    # reduces the rotation to be within range (0..3),
    # meaning north, east, south, west respectively
    def rotation_index
      @rotation % 4
    end

    def move(vector)
      each do |cube|
        cube.x = cube.x + vector[:x]
        cube.y = cube.y + vector[:y]
      end
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
  end
end