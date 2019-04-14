# author: Stephan Becque (https://github.com/sjbecque)
require './cube'

module Tetris
  class Game
    attr_reader :width, :height
    attr_reader :cubes

    def initialize(width = 20, height = 20)
      @width = width
      @height = height

      @cubes = []
      @cubes<< Cube.new(10, 0)
      @cubes<< Cube.new(11, 0)
      @cubes<< Cube.new(10, 1)
      @cubes<< Cube.new(11, 1)
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

    def move_down
      tetronimo_cubes.each do |cube|
        cube.y = cube.y + 1
      end
    end

    def move(direction)
      directions = {
        left: -1,
        right: 1
      }

      tetronimo_cubes.each do |cube|
        cube.x = cube.x + directions.fetch(direction)
      end
    end

    def tetronimo_cubes
      @cubes.select(&:current?)
    end

    def cube(x, y)
      @cubes.find do |cube|
        cube.x == x && cube.y == y
      end
    end
  end
end