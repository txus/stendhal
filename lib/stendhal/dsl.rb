module Stendhal
  module DSL
    module Example
      def it(*args,&blk)
        self.add_example Stendhal::Example.new(*args,&blk)
      end
      def pending(*args,&blk)
        if args.last.is_a? Hash
          options = args.pop
          options.update(:pending => true)
        else
          options = {:pending => true}
        end
        self.add_example Stendhal::Example.new(*args,options,&blk)
      end
    end
  end
end

Stendhal::ExampleGroup.send(:include, Stendhal::DSL::Example)
