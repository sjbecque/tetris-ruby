# author: Stephan Becque (https://github.com/sjbecque)
require './src/cube'
require './src/tetronimo_factory'

module Tetris
  class Game
    attr_reader :width, :height
    attr_reader :tetronimo, :static_cubes, :factory

    def initialize(width = 20, height = 20, tetronimo = [], static_cubes = [])
      @width = width
      @height = height
      @static_cubes = static_cubes
      @factory = TetronimoFactory.new

      if tetronimo.any?
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

      new_tetronimo = move( get_clone(@tetronimo), {x: value, y: 0} )

      unless collision?(new_tetronimo)
        @tetronimo = new_tetronimo
      end
    end

    def rotate(direction)
      origin = origin(@tetronimo)

      if origin
        new_tetronimo = get_clone(@tetronimo).each do |cube|
          cube.rotate(origin, direction)
        end

        new_origin = origin(new_tetronimo)

        rotation_increment = case direction
          when :clockwise then 1
          when :counter_clockwise then -1
        end
        new_origin.rotation = new_origin.rotation + rotation_increment

        move(
          new_tetronimo,
          new_origin.rotation_correction(direction)
        )

        unless collision?(new_tetronimo)
          @tetronimo = new_tetronimo
        end
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
      new_tetronimo = move(get_clone(@tetronimo), {x: 0, y: 1})

      if collision?(new_tetronimo)
        stonify_tetronimo
        init_tetronimo
      else
        @tetronimo = new_tetronimo
      end
    end

    def move(tetronimo, vector)
      tetronimo.each do |cube|
        cube.x = cube.x + vector[:x]
        cube.y = cube.y + vector[:y]
      end
    end

    def collision?(tetronimo)
      bottom_collision?(tetronimo) or boundary_collision?(tetronimo) or cube_collision?(tetronimo)
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

    def origin(tetronimo)
      tetronimo.find{|cube| cube.origin }
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