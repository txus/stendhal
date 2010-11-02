module Stendhal
  module Mocks
    class TestDouble

      attr_accessor :name

      def initialize(name, stubs = {}) 
        @name = name
        assign_stubs(stubs)
      end

      def assign_stubs(stubs)
        stubs.each_pair do |k,v|
          (class << self;self;end).send(:define_method,k.to_sym)  do |*args|
            v 
          end
        end

      end

    end
  end
end
