# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class Stones < CubeSet
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