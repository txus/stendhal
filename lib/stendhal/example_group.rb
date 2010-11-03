module Stendhal
  class ExampleGroup
    @@example_groups = []

    attr_reader :description
    attr_reader :example_groups
    attr_reader :block
    attr_reader :examples

    def initialize(docstring, options = {}, &block)
      @description = docstring
      @block = block
      @parent = options[:parent]
      @example_groups = []
      @examples = []
      instance_exec(&@block) if block_given?
      @@example_groups << self
    end

    def add_example_group(*args, &block)
      if args.last.is_a?(Hash)
        args.last.update(:parent => true)
      else
        args << {:parent => true}
      end
      @example_groups << ExampleGroup.new(*args, &block)
    end

    def has_parent?
      !@parent.nil?
    end

    def run
      Reporter.line @description, :indent => Reporter.current_indentation, :color => :white
      original_indentation = Reporter.current_indentation

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
      group_result = [examples.count, failures, pending]

      @example_groups.each do |group|
        Reporter.current_indentation += 1
        sub_result = group.run
        group_result = group_result.zip(sub_result).map{ |pair| pair[0] + pair[1] } if sub_result
      end
      Reporter.current_indentation = original_indentation

      group_result
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
        Reporter.whitespace
        result = [0,0,0]
        primary_example_groups.each do |g|
          group_result = g.run
          Reporter.whitespace
          result = result.zip(group_result).map{ |pair| pair[0] + pair[1] }
        end
        result
      end

      def primary_example_groups
        @@example_groups.reject { |g| g.has_parent? }
      end

      def count
        @@example_groups.count
      end
    end

  end
end
