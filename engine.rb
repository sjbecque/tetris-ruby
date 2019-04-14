# author: Stephan Becque (https://github.com/sjbecque)

require 'thread'
require './game'
require 'io/console'

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
            unless @test
              render
            end
            @game.next_tick
          end
        end
      end
    end

    def start_input_loop
      loop do
        input = STDIN.getch

        @mutex.synchronize do
          @game.process_user_input(input)
        end
      end
    end

    def render
      @game.grid.each {|row|
        print row.join("")
        print "\n\r" # for proper console outlining
      }
    end
  end
end
