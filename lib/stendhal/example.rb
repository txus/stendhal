module Stendhal
  class Example
    @@examples = []

    attr_reader :description
    attr_reader :block

    def initialize(docstring,&block)
      @description = docstring
      @block = block
      @@examples << self
      @pending = true unless block_given?
    end

    def run
      begin
        @block.call
      rescue=>e
        @exception = e
      end
      $stdout.print "* #{@description}\n"
    end
    
    def pending?
      @pending
    end

  end
end
