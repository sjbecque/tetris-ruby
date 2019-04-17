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

    shared_examples 'handling collision' do
      subject {
        Tetris::Game.new(20, height, tetronimo.dup, static_cubes.dup)
      }

      it 'turns the tetronimo into static cubes' do
        subject.next_tick
        expect(tetronimo).to all(be_static)
      end

      it 'instantiates a new tetronimo' do
        subject.next_tick
        expect(subject.send(:all_cubes).size)
          .to eq (tetronimo.size + static_cubes.size + subject.tetronimo1.size)
      end
    end

    describe 'tetrinomo at the bottom' do
      let(:height) { 20 }

      let(:tetronimo) { [
        Cube.current(10, height - 1),
        Cube.current(11, height - 1)
      ] }

      let(:static_cubes) {
        [ Cube.static(0, height - 1) ]
      }

      it_behaves_like 'handling collision'
    end

    describe 'tetrinomo just above a static cube' do
      let(:height) { 20 }

      let(:tetronimo) { [
        Cube.current(0, height - 3),
        Cube.current(0, height - 2)
      ] }

      let(:static_cubes) {
        [ Cube.static(0, height - 1) ]
      }

      it_behaves_like 'handling collision'
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

    describe 'case of cube collision' do
      let(:tetronimo) { [
        Cube.current(10, 0),
        Cube.current(11, 1)
      ] }

      let(:static_cubes) {
        [ Cube.static(12, 1) ]
      }

      subject {
        Tetris::Game.new(20, 20, tetronimo.dup, static_cubes.dup)
      }

      it "doesn't react" do
        expect{ subject.process_user_input("3") }
        .to_not change{subject.send(:tetronimo).map(&:coordinates) }
      end
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