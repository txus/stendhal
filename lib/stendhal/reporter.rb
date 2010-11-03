require 'singleton'

module Stendhal
  class Reporter
    include ::Singleton

    def initialize
      @current_indentation = 0 
      @output = $stdout
    end

    attr_writer :output
    attr_accessor :current_indentation

    COLORS = 
      {"black" => "30",
       "red" => "31",
       "green" => "32",
       "yellow" => "33",
       "blue" => "34",
       "magenta" => "35",
       "cyan" => "36",
       "white" => "37",

       "RED" => "41",
       "GREEN" => "42",
       "YELLOW" => "43",
       "BLUE" => "44",
       "MAGENTA" => "45",
       "CYAN" => "46",
       "WHITE" => "47"}

    def reset
      @output = $stdout
    end

    def line(text, options = {})
      options[:indent].times { tab } if options[:indent]
      with_color(options[:color]) do
        @output.print text
      end
      @output.print "\n"
    end

    def whitespace
      @output.print "\n"
    end

    def tab
      @output.print "\t"
    end

    # Delegate all methods to instance
    class << self
      def method_missing(*args, &block)
        instance.send(*args, &block)
      end
    end

    private

      def with_color(color,&block)
        return unless block_given?
        if color
          @output.print "\e[0;#{COLORS[color.to_s]}m"
          yield
          @output.print "\e[0m"
        else
          yield
        end
      end

  end
end

