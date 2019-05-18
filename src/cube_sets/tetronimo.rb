# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class Tetronimo < CubeSet
    def self.init_cube(*args)
      Cube.current(*args)
    end

    def rotate(direction)
      return unless origin

      new_tetronimo = clone.each do |cube|
        cube.rotate(origin, direction)
      end

      new_origin = new_tetronimo.origin

      rotation_increment = case direction
        when :clockwise then 1
        when :counter_clockwise then -1
      end
      new_origin.rotation = new_origin.rotation + rotation_increment

      new_tetronimo.move( new_origin.rotation_correction(direction) )

      new_tetronimo
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
  end
end