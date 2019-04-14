# author: Stephan Becque (https://github.com/sjbecque)

require './cube'

describe 'Cube' do

  subject {
    Cube.new(3,3)
  }

  it 'starts out being part of the current tetronimo' do
    expect(subject.current?).to eq true
  end
end