# author: Stephan Becque (https://github.com/sjbecque)

require './src/cube'
require './src/cube_sets/cube_set'
require './src/cube_sets/tetronimo'

describe 'Tetronimo' do
  it {
    expect(Tetris::Tetronimo[ [1,1] ]).to be_a(Tetris::Tetronimo)
  }
end