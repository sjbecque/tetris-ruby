# author: Stephan Becque (https://github.com/sjbecque)
require './cube'
require './tetronimo_factory'

module Tetris
  class Game
    attr_reader :width, :height
    attr_reader :tetronimo, :static_cubes, :factory

    def initialize(test, width = 20, height = 20, tetronimo = [], static_cubes = [])
      @width = width
      @height = height
      @static_cubes = static_cubes
      @factory = TetronimoFactory.new(test)

      if tetronimo.any?
        @tetronimo = tetronimo
      else
        init_tetronimo
      end
    end

    def next_tick
      move_down
    end

    def move(direction)
      directions = {
        left: -1,
        right: 1
      }

      new_tetronimo = get_clone(@tetronimo).each do |cube|
        cube.x = cube.x + directions.fetch(direction)
      end

      unless (boundary_collision?(new_tetronimo) or cube_collision?(new_tetronimo))
        @tetronimo = new_tetronimo
      end
    end

    def grid
      (0...@height).map do |y|
        (0...@width).map do |x|
          (cube(x, y) || "-").to_s
        end
      end
    end


    private

    def init_tetronimo
      @tetronimo = @factory.produce
    end

    def move_down
      new_tetronimo = get_clone(@tetronimo).each do |cube|
        cube.y = cube.y + 1
      end

      if bottom_collision?(new_tetronimo) or cube_collision?(new_tetronimo)
        stonify_tetronimo
        init_tetronimo
      else
        @tetronimo = new_tetronimo
      end
    end

    def bottom_collision?(tetronimo)
      tetronimo.any? do |cube|
        cube.y >= @height
      end
    end

    def cube_collision?(tetronimo)
      (tetronimo.map(&:coordinates) & @static_cubes.map(&:coordinates)).any?
    end

    def stonify_tetronimo
      @tetronimo.each(&:stonify)
      @static_cubes.concat(@tetronimo)
    end

    def boundary_collision?(tetronimo)
      tetronimo.any? do |cube|
        !(0...@width).include?(cube.x)
      end
    end

    def get_clone(cubes)
      cubes.map(&:clone)
    end

    def cube(x, y)
      all_cubes.find do |cube|
        cube.x == x && cube.y == y
      end
    end

    def all_cubes
      @tetronimo + @static_cubes
    end
  end
end