# author: Stephan Becque (https://github.com/sjbecque)

require './tetronimo_factory'

describe 'TetronimoFactory' do

  subject {
    TetronimoFactory.new(true)
  }

  describe 'produce' do
    it {
      expect(subject.produce).to be_a(Array)
    }
  end

end
