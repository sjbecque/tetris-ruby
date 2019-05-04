# author: Stephan Becque (https://github.com/sjbecque)

require './src/cube'

describe 'Cube' do

  subject {
    Tetris::Cube.new(3,3)
  }

  it 'is able to become part of the current tetronimo' do
    expect{ subject.set_current }
      .to change{ subject.current? }
      .from(false).to(true)
  end
end
