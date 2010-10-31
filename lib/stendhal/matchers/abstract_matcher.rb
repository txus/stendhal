module Stendhal
  module Matchers
    class AbstractMatcher
      attr_reader :target

      def initialize(target)
        @target = target
      end

      def match(original, options = {})
        raise NotImplementedError
      end

    end
  end
end
