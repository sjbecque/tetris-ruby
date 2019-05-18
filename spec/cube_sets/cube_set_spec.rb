# author: Stephan Becque (https://github.com/sjbecque)

require './src/cube_sets/cube_set'

describe 'CubeSet' do
  it {
    expect(Tetris::CubeSet.new.clone).to be_a(Tetris::CubeSet)
  }
end