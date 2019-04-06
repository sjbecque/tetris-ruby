# author: Stephan Becque (https://github.com/sjbecque)

require './engine.rb'
require 'timeout'

describe 'Engine' do

  describe 'the engine loop' do
    it 'successfully produces list items and receives user input' do
      engine = Tetris::Engine.new(test: true)
      sleep 3
      engine.mutex.synchronize do
        engine.game.process_user_input("input")
      end
      expect(engine.game.items).to eq ["value", "value", "input", "value"]
    end
  end

end