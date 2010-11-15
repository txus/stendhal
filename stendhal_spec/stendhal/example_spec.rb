module Stendhal
  describe "Example" do

    it "is created with a docstring and a block" do
      example = Example.new("docstring") do
        3 + 4
      end
      example.description.must eq("docstring")
    end

    it "is pending unless given a block" do
      example = Example.new("pending")
      example.must be_pending
    end

    describe "#run" do

      it "calls the block" do
        example = Example.new("docstring") do
          3 + 4 
        end
        example.expects(:instance_eval)

        example.run
      end

      it "captures unmet expectations" do
        example = Example.new("docstring") do
          raise Stendhal::Exceptions::ExpectationNotMet.new("expected this example to be awesome")
        end
        lambda {example.run}.must_not raise_error
        example.run
        example.must be_failed
        example.failed_message.must eq("expected this example to be awesome")
      end

      it "captures exceptions" do
        example = Example.new("docstring") do
          raise "error"
        end
        lambda {example.run}.must_not raise_error
        example.run
        example.must be_aborted
      end

      it "captures everything else" do
        example = Example.new("docstring") do
          hello my dear reader
        end
        lambda {example.run}.must_not raise_error
        example.run
        example.must be_aborted
      end

      it "verifies all message expectations after running the block" do
        example = Example.new("docstring") do
          
        end
        example.expects(:instance_eval)
        Stendhal::Mocks::MockVerifier.expects(:verify!)

        example.run
      end

      it "resets all message expectations before running the block" do
        example = Example.new("docstring") do
          
        end
        Stendhal::Mocks::MockVerifier.expects(:reset!)
        example.expects(:instance_eval)

        example.run
      end

    end

    describe "#fail" do
      it 'fails with a given message' do
        example = Example.new("docstring") do
          fail "expectation not awesome enough"
        end
        example.run
        example.must be_failed
        example.failed_message.must eq("expectation not awesome enough")
      end
    end

    describe "class methods" do
      describe "#count" do
        it "returns the number of examples in memory" do
          before_count = Example.count
          Example.new("pending")
          Example.count.must eq(before_count + 1)
        end
      end
    end

  end
end
