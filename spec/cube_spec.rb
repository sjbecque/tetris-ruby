# author: Stephan Becque (https://github.com/sjbecque)

require './src/cube'

describe 'Cube' do

  subject {
    Tetris::Cube.new(5,2)
  }

  it 'is able to become part of the current tetronimo' do
    expect{ subject.set_current }
      .to change{ subject.current? }
      .from(false).to(true)
  end

  describe '+' do
    it 'adds another Cube vector' do
      expect( subject + Tetris::Cube.new(1,1) ).to eq( Tetris::Cube.new(6,3) )
    end
  end

  describe 'rotate' do
    let(:origin) { Tetris::Cube.new(1,1) }

    it 'rotates counter-clockwise relative to origin (note that y-axis points south)' do
      expect{ subject.rotate(origin, :counter_clockwise) }
        .to change{ subject.coordinates }
        .from([5,2])
        .to( (origin + Tetris::Cube.new(1,-4)).coordinates )
    end
  end

end
