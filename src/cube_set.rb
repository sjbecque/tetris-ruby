# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class CubeSet
    include Enumerable

    attr_accessor :cubes

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

    def clone
      cubeset = CubeSet.new
      cubeset.cubes = @cubes.map(&:clone)
      cubeset
    end
  end

  class Tetronimo < CubeSet
    def self.init_cube(*args)
      Cube.current(*args)
    end
  end

  class StaticCubes < CubeSet
    def self.init_cube(*args)
      Cube.static(*args)
    end

    def add(cubeset)
      new_cubes = cubeset.cubes
      new_cubes.each(&:stonify)
      @cubes += new_cubes
    end
  end

end