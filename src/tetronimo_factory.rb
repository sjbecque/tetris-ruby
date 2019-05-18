# author: Stephan Becque (https://github.com/sjbecque)

require './src/cube'
require './src/cube_sets/cube_set'

# "factory" is maybe a bit too strong term for this class
# (and there is no polymorphism needed ;)

module Tetris
  class TetronimoFactory

    def produce
      tetronimos[rand(0...tetronimos.size)]
    end

    private

    def tetronimos
      [
        Tetris::Tetronimo[
          [10, 0],
          [10, 1, true, {
            0 => [{ x:-1, y:0 } , { x:-1, y:1 }],
            1 => [{ x:1 , y:-1} , { x:0 , y:-1}],
            2 => [{ x:0 , y:1 } , { x:0 , y:0 }],
            3 => [{ x:0 , y:0 } , { x:1 , y:0 }]
          }],
          [11, 1],
          [11, 2]
        ],
        Tetris::Tetronimo[[10, 0], [11, 0],       [10, 1], [11, 1]],
        Tetris::Tetronimo[[10, 0], [10, 1, true], [10, 2], [11, 1]],
        Tetris::Tetronimo[[10, 0], [10, 1, true], [10, 2], [10, 3]]
      ]
    end
  end
end
