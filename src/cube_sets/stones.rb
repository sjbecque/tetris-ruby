# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class Stones < CubeSet
    def self.init_cube(*args)
      Cube.stone(*args)
    end

    def add(cubeset)
      new_cubes = cubeset.cubes
      new_cubes.each(&:stonify)
      @cubes += new_cubes
    end

    def process_completed_rows(width, height)
      while y_value = lowest_completed_row_y_value(width, height)
        delete_row(y_value)
      end

      self
    end

    private

    def lowest_completed_row_y_value(width, height)
      (0...height).to_a.select do |y_value|
        row(y_value).size == width
      end.last
    end

    def delete_row(y_value)
      @cubes = @cubes.reject do |cube|
        cube.y == y_value
      end

      cubes_above = @cubes.select do |cube|
        cube.y < y_value
      end

      cubes_above.each do |cube|
        cube.y += 1
      end
    end

    def row(y_value)
      @cubes.select do |cube|
        cube.y == y_value
      end
    end
  end
end