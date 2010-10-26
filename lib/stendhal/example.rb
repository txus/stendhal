module Stendhal
  class Example
    include Assertions

    @@examples = []

    attr_reader :description
    attr_reader :block

    def initialize(docstring, options = {}, &block)
      @description = docstring
      @block = block
      @pending = true if options[:pending] || !block_given?
      @@examples << self
    end

    def run
      begin
        self.instance_eval(&@block)
        return 0
      rescue AssertionFailed=>e
        @failed = true
        return 1
      rescue StandardError=>e
        @aborted = true
        return 1
      end
    end
    
    def pending?
      @pending
    end

    def failed?
      @failed
    end

    def aborted?
      @aborted
    end

    def destroy
      @@examples.delete self
    end

    def self.run_all
      failures = pending = 0
      @@examples.reject do |example|
        if example.pending? 
          pending += 1
          $stdout.print "* #{example.description}\n"
          true
        else
          false
        end
      end.each do |example|
        failures += example.run
        $stdout.print "* #{example.description}\n"
      end
      [Example.count, failures, pending]
    end

    def self.destroy_all
      @@examples = []
    end

    def self.count
      @@examples.count
    end

  end
end
