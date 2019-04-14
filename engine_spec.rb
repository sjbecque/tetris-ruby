# author: Stephan Becque (https://github.com/sjbecque)

require './engine.rb'
require 'timeout'

describe 'Engine' do

  describe 'the engine loop' do
    let!(:engine) {
      Tetris::Engine.new(test: true)
    }

    it 'tells the game periodically to advance to next tick' do
      expect(engine.game).to receive(:next_tick).exactly(3).times
      sleep 3.5
    end
  end

end