# author: Stephan Becque (https://github.com/sjbecque)

require './src/engine.rb'
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

    it 'quits when hitting "q"' do
      expect(engine).to receive(:exit)
      engine.send(:process_user_input, 'q')
    end
  end

end