# author: Stephan Becque (https://github.com/sjbecque)

require './src/engine'
require './src/cube'

describe 'Game' do

  subject {
    Tetris::Game.new(width, height, tetronimo.dup, static_cubes.dup)
  }

  let(:factory) { Tetris::TetronimoFactory.new }
  let(:tetronimo) { factory.send(:tetronimos).first }
  let(:static_cubes) { [] }
  let(:width) { 20 }
  let(:height) { 20 }


  shared_examples 'handling moving-down collision' do
    it 'turns the tetronimo into static cubes' do
      subject.next_tick
      expect(tetronimo).to all(be_static)
    end

    it 'instantiates a new tetronimo while retaining all static_cubes' do
      subject.next_tick
      expect(subject.send(:all_cubes).size)
        .to eq (tetronimo.size + static_cubes.size + subject.factory.produce.size)
    end
  end

  shared_examples 'handling horizontal collision' do |command|
    it 'lets the tetronimo stay put' do
      expect{ subject.move_horizontal(command) }
      .to_not change{subject.send(:tetronimo).map(&:coordinates) }
    end
  end


  it 'assigns an array of cubes' do
    expect(subject.send(:all_cubes)).to all(be_a(Tetris::Cube))
  end

  describe 'next_tick' do
    it 'moves the tetronimo down one spot' do
      expect{ subject.next_tick }
      .to change{subject.send(:tetronimo).map(&:y)}
      .from( [0, 1, 1, 2] )
      .to( [1, 2, 2, 3] )
    end

    describe 'tetrinomo at the bottom' do
      let(:tetronimo) { [
        Tetris::Cube.current(10, height - 1),
        Tetris::Cube.current(11, height - 1)
      ] }

      let(:static_cubes) {
        [ Tetris::Cube.static(0, height - 1) ]
      }

      it_behaves_like 'handling moving-down collision'
    end

    describe 'tetrinomo just above a static cube' do
      let(:height) { 20 }

      let(:tetronimo) { [
        Tetris::Cube.current(0, height - 3),
        Tetris::Cube.current(0, height - 2)
      ] }

      let(:static_cubes) {
        [ Tetris::Cube.static(0, height - 1) ]
      }

      it_behaves_like 'handling moving-down collision'
    end

  end

  describe 'process_user_input' do
    it 'moves tetronimo to the left' do
      expect{ subject.move_horizontal(:left) }
      .to change{subject.send(:tetronimo).map(&:x)}
      .from( [10, 10, 11, 11] )
      .to([9, 9, 10, 10])
    end

    it 'moves tetronimo to the right' do
      expect{ subject.move_horizontal(:right) }
      .to change{subject.send(:tetronimo).map(&:x)}
      .from( [10, 10, 11, 11] )
      .to([11, 11, 12, 12])
    end

    describe 'rotate' do
      it 'rotates tetronimo clockwise (note that y-axis points south) and performs rotation correction' do
        expect{ subject.rotate(:clockwise) }
        .to change{subject.send(:tetronimo) }
        .to(
          [
            Tetris::Cube.new(12, 0, false),
            Tetris::Cube.new(11, 0, true),
            Tetris::Cube.new(11, 1, false),
            Tetris::Cube.new(10, 1, false)
          ]
        )
      end
    end

    describe 'when at the leftedge' do
      let(:tetronimo) { [
        Tetris::Cube.current(0, 0)
      ] }

      it_behaves_like 'handling horizontal collision', :left
    end

    describe 'when at the right edge' do
      let(:tetronimo) { [
        Tetris::Cube.current(19, 0)
      ] }

      it_behaves_like 'handling horizontal collision', :right
    end

    describe 'case of cube collision' do
      let(:tetronimo) { [
        Tetris::Cube.current(10, 0),
        Tetris::Cube.current(11, 1)
      ] }

      let(:static_cubes) {
        [ Tetris::Cube.static(12, 1) ]
      }

      it "doesn't react" do
        expect{ subject.move_horizontal(:right) }
        .to_not change{subject.send(:tetronimo).map(&:coordinates) }
      end
    end

  end

  describe 'grid' do
    it 'produces rows of cubes and nils' do
      expect(subject.grid{|cube| cube }.flatten.compact).to be_all(Tetris::Cube)
    end

    it 'has the right dimensions' do
      expect(subject.grid{|row| row}.first.size).to eq subject.width
      expect(subject.grid{|row| row}.size).to eq subject.height
    end

    it 'returns cubes and empty fields at the right spots' do
      expect( subject.grid{|cube| cube}[0][10] ).to be_a(Tetris::Cube)
    end
  end

end
