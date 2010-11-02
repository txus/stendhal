module Stendhal
  class ExampleGroup
    @@example_groups = []

    attr_reader :description
    attr_reader :block
    attr_reader :examples

    def initialize(docstring, options = {}, &block)
      @description = docstring
      @block = block
      @examples = []
      instance_exec(&@block) if block_given?
      @@example_groups << self
    end

    def run
      failures = pending = 0
      examples.reject do |example|
        if example.pending? 
          pending += 1
          $stdout.print "* #{example.description} [PENDING]\n"
          true
        else
          false
        end
      end.each do |example|
        failures += example.run
        status = " [FAILED]" if example.failed?
        status = " [ABORTED]" if example.aborted?
        $stdout.print "* #{example.description}#{status || ''}\n"
        $stdout.print "\t#{example.failed_message}\n" if example.failed?
        $stdout.print "\t#{example.aborted_message}\n" if example.aborted?
      end
      [examples.count, failures, pending]
    end

    def add_example(example)
      examples << example 
    end

    class << self
      attr_reader :example_groups

      def destroy_all
        @@example_groups = []
      end

      def run_all
        result = [0,0,0]
        @@example_groups.each do |g|
          puts "\n"
          puts g.description
          group_result = g.run
          result = result.zip(group_result).map{ |pair| pair[0] + pair[1] }
        end
        result
      end

      def count
        @@example_groups.count
      end
    end

  end
end
