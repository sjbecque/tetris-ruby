# author: Stephan Becque (https://github.com/sjbecque)

require './engine.rb'
require './cube'

describe 'Game' do

  subject {
    Tetris::Game.new
  }

  it 'assigns an array of cubes' do
    expect(subject.cubes).to all(be_a(Cube))
  end

  describe 'next_tick' do
    it 'moves the tetronimo down one spot' do
      expect{ subject.next_tick }
      .to change{subject.send(:tetronimo_cubes).map(&:y)}
      .from( [10, 11, 10, 11] )
      .to([11, 12, 11, 12])
    end
  end

  describe 'process_user_input' do
    it 'adds user input to items' do
      expect{ subject.process_user_input("input") }
      .to change{subject.items}.from([]).to(["input"])
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