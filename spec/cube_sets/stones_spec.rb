# author: Stephan Becque (https://github.com/sjbecque)

require './src/cube'
require './src/cube_sets/cube_set'
require './src/cube_sets/stones'

describe 'Tetronimo' do
  it {
    expect(Tetris::Stones[ [1,1] ]).to be_a(Tetris::Stones)
  }

  describe 'process_completed_rows' do
    let(:subject) {
      Tetris::Stones[
               [2,1],
        [1,2], [2,2],
        [1,3],
        [1,4], [2,4],
        [1,5]
      ]
    }
    it 'removes all full rows and moves all stones above it down' do
      expect(subject.process_completed_rows(2,5)).to eq(
        Tetris::Stones[
          [2,3], [1,4], [1,5]
        ]
      )
    end
  end
end