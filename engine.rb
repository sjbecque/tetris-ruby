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
            @game.next_tick
            unless @test
              render
            end
          end
        end
      end
    end

    def start_input_loop
      loop do
        input = STDIN.getch

        @mutex.synchronize do
          process_user_input(input)
          render
        end
      end
    end

    def process_user_input(input)
      case input
      when '1'
        @game.move(:left)
      when '3'
        @game.move(:right)
      when 'q'
        exit
      end
    end

    def render
      print "======================\n"
      @game.grid.each {|row|
        print row.join("")
        print "\n\r" # for proper console outlining
      }
    end
  end
end
