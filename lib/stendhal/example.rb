module Stendhal
  class Example
    include Matchers
    include Mocks

    @@examples = []

    attr_reader :description
    attr_reader :block
    attr_reader :failed_message
    attr_reader :aborted_message

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
      rescue Exceptions::ExpectationNotMet=>e
        @failed = true
        @failed_message = e.message
        return 1
      rescue StandardError=>e
        @aborted = true
        @aborted_message = e.message
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

    def fail(message = 'failed')
      raise Stendhal::Exceptions::ExpectationNotMet.new(message)
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
