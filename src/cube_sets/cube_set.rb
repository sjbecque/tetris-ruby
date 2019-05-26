# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class CubeSet
    include Enumerable

    attr_accessor :cubes

    def initialize
      @cubes = []
    end

    def self.[](*cubes_args)
      instance = new
      instance.cubes = cubes_args.map do |cube_args|
        init_cube(*cube_args)
      end
      instance
    end

    def coordinates
      cubes.map(&:coordinates)
    end

    def each(&block)
      @cubes.each(&block)
      self
    end

    def get(x,y)
      @cubes.find do |cube|
        cube.x == x && cube.y == y
      end
    end

    def self.init_cube(*args)
      Cube.new(*args)
    end

    def ==(other)
      @cubes.map(&:coordinates).sort == other.cubes.map(&:coordinates).sort
    end

    def clone
      cube_set = self.class.new
      cube_set.cubes = @cubes.map(&:clone)
      cube_set
    end
  end
end