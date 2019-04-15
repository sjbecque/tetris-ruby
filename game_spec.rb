# author: Stephan Becque (https://github.com/sjbecque)

require './engine.rb'
require './cube'

describe 'Game' do

  subject {
    Tetris::Game.new
  }

  it 'assigns an array of cubes' do
    expect(subject.send(:all_cubes)).to all(be_a(Cube))
  end

  describe 'next_tick' do
    it 'moves the tetronimo down one spot' do
      expect{ subject.next_tick }
      .to change{subject.send(:tetronimo).map(&:y)}
      .from( [0, 0, 1, 1] )
      .to( [1, 1, 2, 2] )
    end
  end

  describe 'process_user_input' do
    it 'moves tetronimo to the left if told' do
      expect{ subject.process_user_input("1") }
      .to change{subject.send(:tetronimo).map(&:x)}
      .from( [10, 11, 10, 11] )
      .to([9, 10, 9, 10])
    end

    it 'moves tetronimo to the right if told' do
      expect{ subject.process_user_input("3") }
      .to change{subject.send(:tetronimo).map(&:x)}
      .from( [10, 11, 10, 11] )
      .to([11, 12, 11, 12])
    end

    it 'quits when hitting "q"' do
      expect(subject).to receive(:exit)
      subject.process_user_input("q")
    end
  end

  describe 'grid' do
    it 'has the right width' do
      expect(subject.grid.size).to eq (subject.width)
    end

    it 'returns cubes and empty fields at the right spots' do
      expect(subject.grid[0][10]).to eq "x"
      expect(subject.grid[0][0]).to eq "-"
    end
  end
end