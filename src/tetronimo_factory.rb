# author: Stephan Becque (https://github.com/sjbecque)

require './src/cube'

# "factory" is maybe a bit too strong term for this class
# (and there is no polymorphism needed ;)

module Tetris
  class TetronimoFactory

    def initialize(test)
      @test = test
    end

    def produce
      tetronimos[@test ? 0 : rand(0...tetronimos.size)]
    end

    private

    def tetronimos
      [
        [
          Cube.current(10, 0),
          Cube.current(10, 1, true) do |direction|
            vectors = {
              0 => [{ x:-1, y:0 } , { x:-1, y:1 }],
              1 => [{ x:1 , y:-1} , { x:0 , y:-1}],
              2 => [{ x:0 , y:1 } , { x:0 , y:0 }],
              3 => [{ x:0 , y:0 } , { x:1 , y:0 }]
            }[self.rotation_index]

            direction == :clockwise ? vectors.first : vectors.last
          end,
          Cube.current(11, 1),
          Cube.current(11, 2)
        ],
        [
          Cube.current(10, 0),
          Cube.current(11, 0),
          Cube.current(10, 1),
          Cube.current(11, 1)
        ],
        [
          Cube.current(10, 0),
          Cube.current(10, 1, 0),
          Cube.current(10, 2),
          Cube.current(11, 1)
        ],
        [
          Cube.current(10, 0),
          Cube.current(10, 1, 0),
          Cube.current(10, 2),
          Cube.current(10, 3)
        ]
      ]
    end
  end
end
