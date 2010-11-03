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
          Reporter.line "* #{example.description} [PENDING]", :indent => Reporter.current_indentation + 1, :color => :yellow
          true
        else
          false
        end
      end.each do |example|
        failures += example.run
        color = :red
        color = :green unless example.failed? || example.aborted?
        status = " [FAILED]" if example.failed?
        status = " [ABORTED]" if example.aborted?
        Reporter.line "* #{example.description}#{status || ''}", :indent => Reporter.current_indentation + 1, :color => color
        Reporter.line "#{example.failed_message}", :indent => Reporter.current_indentation + 2, :color => :red if example.failed?
        Reporter.line "#{example.aborted_message}", :indent => Reporter.current_indentation + 2, :color => :red if example.aborted?
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
          Reporter.whitespace
          Reporter.line g.description, :indent => Reporter.current_indentation, :color => :white
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
