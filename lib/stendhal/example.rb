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

    class << self

      def destroy_all
        @@examples = []
      end

      def count
        @@examples.count
      end

    end

  end
end
