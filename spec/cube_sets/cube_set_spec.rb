# author: Stephan Becque (https://github.com/sjbecque)

require './src/cube_sets/cube_set'
require './src/cube'

describe 'CubeSet' do
  it {
    expect(Tetris::CubeSet.new.clone).to be_a(Tetris::CubeSet)
  }

  describe '==' do
    it {
      expect(Tetris::CubeSet[[2,1],[1,2]] == Tetris::CubeSet[[1,2],[2,1]] ).to eq true
      expect(Tetris::CubeSet[[2,1],[1,2]] == Tetris::CubeSet[[1,2],[1,2]] ).to eq false
    }
  end
end