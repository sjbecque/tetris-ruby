# author: Stephan Becque (https://github.com/sjbecque)

require './src/tetronimo_factory'

describe 'TetronimoFactory' do

  subject {
    Tetris::TetronimoFactory.new(true)
  }

  describe 'produce' do
    it {
      expect(subject.produce).to be_a(Array)
    }
  end

end
