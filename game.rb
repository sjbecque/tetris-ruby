# author: Stephan Becque (https://github.com/sjbecque)
require './cube'

module Tetris
  class Game
    attr_reader :width, :height
    attr_reader :tetronimo, :static_cubes

    def initialize(width = 20, height = 20, tetronimo = [], static_cubes = [])
      @width = width
      @height = height
      @static_cubes = static_cubes

      @tetronimo = tetronimo
      unless @tetronimo.any?
        init_tetronimo
      end
    end

    def next_tick
      move_down
    end

    def process_user_input(input)
      key = input[0]
      case key
      when 'q'
        exit
      when '1'
        move(:left)
      when '3'
        move(:right)
      end
    end

    def grid
      (0...@height).map do |y|
        (0...@width).map do |x|
          (cube(x, y) || "-").to_s
        end
      end
    end

    def tetronimo1
      [
        Cube.current(10, 0),
        Cube.current(11, 0),
        Cube.current(10, 1),
        Cube.current(11, 1)
      ]
    end

    private

    def init_tetronimo
      @tetronimo = tetronimo1
    end

    def move_down
      new_tetronimo = get_clone(@tetronimo).each do |cube|
        cube.y = cube.y + 1
      end

      if bottom_collision?(new_tetronimo)
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

    def stonify_tetronimo
      @tetronimo.each(&:stonify)
      @static_cubes.concat(@tetronimo)
    end

    def move(direction)
      directions = {
        left: -1,
        right: 1
      }

      @tetronimo.each do |cube|
        cube.x = cube.x + directions.fetch(direction)
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