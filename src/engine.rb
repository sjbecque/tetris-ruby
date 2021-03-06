# author: Stephan Becque (https://github.com/sjbecque)

require 'thread'
require './src/game'
require 'io/console'
require 'eventmachine'
require 'em-websocket'

module Tetris
  class Engine
    attr_accessor :game
    attr_accessor :mutex

    def initialize(test: false, console: false)
      @test = test
      @console = console
      @game = Game.new
      @mutex = Mutex.new

      if (not @test and not @console)
        start_browser
        start_ui_websocket
        sleep 0.1
      end
      start_time_loop
      start_input_loop unless @test
      self
    end

    private

    def start_browser
      `x-www-browser ui.html`
    end

    def start_time_loop
      @time_loop = Thread.new do

        loop do
          sleep 1
          @mutex.synchronize do
            @game.next_tick
            render unless @test
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
      when '4'
        @game.move_horizontal(:left)
      when '6'
        @game.move_horizontal(:right)
      when '1'
        @game.rotate(:counter_clockwise)
      when '3'
        @game.rotate(:clockwise)
      when 'q'
        exit
      else
        # ignore
      end
    end

    def render
      if @console
        rows = @game.grid {|cube| (cube || "-").to_s }

        print "======================\n"
        rows.each do |row|
          print row.join
          print "\n\r" # for proper console outlining
        end
      else
        raise RuntimeError, "no websocket" unless @event_machine["websocket"]

        str = @game.grid {|cube| cube&.value.to_s || "" }.to_s
        @event_machine["websocket"].send(str)
      end
    end

    def start_ui_websocket
      @event_machine = Thread.new {

        EventMachine.run do
          EventMachine::WebSocket.start(host: "0.0.0.0", port: 8080) do |websocket|
            puts "--- start websocket"
            Thread.current["websocket"] = websocket

            websocket.onopen { puts "WebSocket connection open" }
            websocket.onclose { puts "WebSocket connection closed" }

            websocket.onmessage do |msg| process_user_input(msg) end
          end
        end
      }

    end
  end
end
