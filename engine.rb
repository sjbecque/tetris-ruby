# author: Stephan Becque (https://github.com/sjbecque)

require 'thread'
require './game'

module Tetris
  class Engine
    attr_accessor :game
    attr_accessor :mutex

    def initialize(test: false)
      @game = Game.new
      @mutex = Mutex.new
      @test = test

      start_time_loop
      start_input_loop unless @test
      self
    end

    private

    def start_time_loop
      @time_loop = Thread.new do
        loop do
          sleep 1

          @mutex.synchronize do
            @game.next_tick
            system("reset") unless @test
            render
          end
        end
      end
    end

    def start_input_loop
      loop do
        input = gets

        @mutex.synchronize do
          @game.process_user_input(input)
        end
      end
    end

    def render
      @game.grid.each {|row| puts row.join("") }
    end
  end
end
