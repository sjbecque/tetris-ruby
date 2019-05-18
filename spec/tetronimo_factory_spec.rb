# author: Stephan Becque (https://github.com/sjbecque)

require './src/tetronimo_factory'

describe 'TetronimoFactory' do

  subject {
    Tetris::TetronimoFactory.new
  }

  describe 'produce' do
    it {
      expect(subject.produce).to be_a(Tetris::Tetronimo)
    }
  end

end
