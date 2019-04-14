# author: Stephan Becque (https://github.com/sjbecque)
require './cube'

module Tetris
  class Game
    attr_reader :items
    attr_reader :width, :height
    attr_reader :cubes

    def initialize(width = 20, height = 20)
      @items = []

      @width = width
      @height = height

      @cubes = []
      @cubes<< Cube.new(0, 10)
      @cubes<< Cube.new(0, 11)
      @cubes<< Cube.new(1, 10)
      @cubes<< Cube.new(1, 11)
    end

    def next_tick
      @items<< "value"
    end

    def process_user_input(input)
      if input[0] == 'q'
        exit
      end

      @items<< input
    end

    def grid
      (0...@width).map do |x|
        (0...@height).map do |y|
          (cube(x, y) || "-").to_s
        end
      end
    end

    private

    def cube(x, y)
      @cubes.find do |cube|
        cube.x == x && cube.y == y
      end
    end
  end
end