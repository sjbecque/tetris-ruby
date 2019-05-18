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

    def clone
      cubeset = self.class.new
      cubeset.cubes = @cubes.map(&:clone)
      cubeset
    end
  end
end