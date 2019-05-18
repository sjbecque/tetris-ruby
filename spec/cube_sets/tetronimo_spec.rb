# author: Stephan Becque (https://github.com/sjbecque)

require './src/cube'
require './src/cube_sets/cube_set'
require './src/cube_sets/tetronimo'

describe 'Tetronimo' do
  it {
    expect(Tetris::Tetronimo[ [1,1] ]).to be_a(Tetris::Tetronimo)
  }

  describe 'clone' do
    let(:subject) { Tetris::Tetronimo[ [1,1] ] }
    let(:rotation) { 1 }
    let(:corrections) { {} }

    before do
      subject.rotation = rotation
      subject.rotation_corrections = corrections
    end

    it 'copies all properties' do
      expect(subject.clone.rotation).to eq(rotation)
      expect(subject.clone.rotation_corrections).to eq(corrections)
    end
  end
end