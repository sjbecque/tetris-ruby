# author: Stephan Becque (https://github.com/sjbecque)
require './cube'

module Tetris
  class Game
    attr_reader :width, :height
    attr_reader :tetronimo, :static_cubes

    def initialize(width = 20, height = 20, tetronimo = [])
      @width = width
      @height = height
      @static_cubes = []

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

    private

    def init_tetronimo
      @tetronimo = [
        Cube.new(10, 0),
        Cube.new(11, 0),
        Cube.new(10, 1),
        Cube.new(11, 1)
      ]
    end

    def move_down
      @tetronimo.each do |cube|
        cube.y = cube.y + 1
      end
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