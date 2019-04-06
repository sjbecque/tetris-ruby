# author: Stephan Becque (https://github.com/sjbecque)

module Tetris
  class Game
    attr_reader :items

    def initialize
      @items = []
    end

    def next_tick
      @items<< "value"
    end

    def process_user_input(input)
      @items<< input
    end
  end
end