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

    def destroy
      @@examples.delete self
    end

    def self.run_all
      @@examples.reject{|n| n.pending?}.each{|n|n.run} 
    end

    def self.destroy_all
      @@examples = []
    end

    def self.count
      @@examples.count
    end

  end
end
