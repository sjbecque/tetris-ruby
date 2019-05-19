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
        Tetris::Tetronimo[ [10, 0], [10, 1, true], [11, 1], [11, 2] ].set_rotation_corrections(
          {
            0 => { clockwise: { x:-1, y:0 } , counter_clockwise: { x:-1, y:1 } },
            1 => { clockwise: { x:1 , y:-1} , counter_clockwise: { x:0 , y:-1} },
            2 => { clockwise: { x:0 , y:1 } , counter_clockwise: { x:0 , y:0 } },
            3 => { clockwise: { x:0 , y:0 } , counter_clockwise: { x:1 , y:0 } }
          }
        ),
        Tetris::Tetronimo[[10, 0], [11, 0],       [10, 1], [11, 1]],
        Tetris::Tetronimo[[10, 0], [10, 1, true], [10, 2], [11, 1]],
        Tetris::Tetronimo[[10, 0], [10, 1, true], [10, 2], [10, 3]]
      ]
    end

  end
end
