# author: Stephan Becque (https://github.com/sjbecque)

require './engine.rb'

describe 'Game' do

  subject {
    Tetris::Game.new
  }

  describe 'next_tick' do
    it 'adds a value to items' do
      expect{ subject.next_tick }
      .to change{subject.items}.from([]).to(["value"])
    end
  end

  describe 'process_user_input' do
    it 'adds user input to items' do
      expect{ subject.process_user_input("input") }
      .to change{subject.items}.from([]).to(["input"])
    end
  end
end