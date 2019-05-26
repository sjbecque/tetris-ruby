# author: Stephan Becque (https://github.com/sjbecque)
require './src/cube'
require './src/tetronimo_factory'
require './src/cube_sets/cube_set'
require './src/cube_sets/stones'
require './src/cube_sets/tetronimo'

module Tetris
  class Game
    attr_reader :width, :height
    attr_reader :tetronimo, :stones, :factory

    def initialize(width = 20, height = 20, tetronimo = nil, stones = Stones[])
      @width = width
      @height = height
      @stones = stones
      @factory = TetronimoFactory.new

      if tetronimo
        @tetronimo = tetronimo
      else
        init_tetronimo
      end
    end

    def next_tick
      move_down
    end

    def move_horizontal(direction)
      value = {
        left: -1,
        right: 1
      }.fetch(direction)

      new_tetronimo = @tetronimo.clone.move( {x: value, y: 0} )

      unless collision?(new_tetronimo)
        @tetronimo = new_tetronimo
      end
    end

    def rotate(direction)
      return unless @tetronimo.origin

      new_tetronimo = @tetronimo.clone.rotate(direction)

      unless collision?(new_tetronimo)
        @tetronimo = new_tetronimo
      end
    end

    # provide the rows of cubes for (engine) consumer
    # note, also provides nil to yield
    # alternatively we could define an empty Cube to prevents nil's, then
    # yield a block would become unnecessary, but now makes for nice demo
    def grid
      (0...@height).map do |y|
        (0...@width).map do |x|
          yield cube(x,y)
        end
      end
    end


    private


    def init_tetronimo
      @tetronimo = @factory.produce
    end

    def move_down
      new_tetronimo = @tetronimo.clone.move({x: 0, y: 1})

      if collision?(new_tetronimo)
        stonify_tetronimo
        @stones.process_completed_rows(@width, @height)
        init_tetronimo
      else
        @tetronimo = new_tetronimo
      end
    end

    def collision?(tetronimo)
      tetronimo.bottom_collision?(@height) or
      tetronimo.boundary_collision?(@width) or
      cube_collision?(tetronimo, @stones)
    end

    def cube_collision?(tetronimo, stones)
      (tetronimo.coordinates & stones.coordinates).any?
    end

    def stonify_tetronimo
      @stones.add(@tetronimo)
    end

    def cube(x, y)
      @tetronimo.get(x,y) || @stones.get(x,y)
    end
  end
end