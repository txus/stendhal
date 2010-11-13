module Stendhal
  module Mocks
    class MockVerifier

      @@verifiers = []

      attr_reader :expectations

      def initialize(object)
        @expectations = []
        @object = object
        @@verifiers << self
      end

      def add_expectation(method, options = {})
        @expectations.detect {|e| e.method == method }.tap do |expectation|
          expectation and begin
            options[:negative] ? expectation.times_expected = 0 :
                                 expectation.times_expected += 1
          end
        end || @expectations << MessageExpectation.new(method, options)
      end

      def add_negative_expectation(method)
        add_expectation(method, :negative => true)
      end

      def fulfill_expectation(method)
        @expectations.select{|e| e.method == method}.each(&:register_call)
      end
      
      def verify!
        expectations.each do |expectation|
          begin
            expectation.verify
          rescue Stendhal::Exceptions::ExpectationNotMet=>e
            raise Stendhal::Exceptions::ExpectationNotMet.new "#{@object} #{e.message}"
          end
        end
      end

      def self.verifiers
        @@verifiers
      end

      def self.verify!
        verifiers.each(&:verify!)
      end

      def self.reset!
        @@verifiers = []
      end

      class MessageExpectation
        attr_reader :method
        attr_reader :times_called
        attr_accessor :times_expected

        def initialize(method, options = {})
          @method = method
          @times_expected = options[:negative] ? 0 : 1
          @times_called = 0
        end

        def register_call
          puts "#{@times_called}"
          @times_called += 1
        end

        def verify
          raise Stendhal::Exceptions::ExpectationNotMet.new "expected to be sent :#{method} #{times_expected} time#{times_expected == 1 ? '' : 's'}, but received it #{times_called} time#{times_called == 1 ? '' : 's'}" unless times_expected == times_called
        end
      end

    end
  end
end
