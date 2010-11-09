require 'spec_helper'

module Stendhal
  describe Example do

    before(:each) do
      Example.destroy_all
    end

    let(:example_group) { double('example group') }

    it "is created with a docstring and a block" do
      example = Example.new("docstring") do
        3 + 4
      end
      example.description.should == "docstring"
    end

    it "is pending unless given a block" do
      example = Example.new("pending")
      example.should be_pending
    end

    describe "#run" do

      it "calls the block" do
        example = Example.new("docstring") do
          3 + 4 
        end
        example.should_receive(:instance_eval)

        example.run
      end

      it "captures unmet expectations" do
        example = Example.new("docstring") do
          raise Stendhal::Exceptions::ExpectationNotMet.new("expected this example to be awesome")
        end
        expect {example.run}.to_not raise_error
        example.run
        example.should be_failed
        example.failed_message.should == "expected this example to be awesome"
      end

      it "captures exceptions" do
        example = Example.new("docstring") do
          raise "error"
        end
        expect {example.run}.to_not raise_error
        example.run
        example.should be_aborted
      end

      it "captures everything else" do
        example = Example.new("docstring") do
          hello my dear reader
        end
        expect {example.run}.to_not raise_error
        example.run
        example.should be_aborted
      end

      it "verifies all message expectations after running the block" do
        example = Example.new("docstring") do
          
        end
        example.should_receive(:instance_eval).ordered
        Stendhal::Mocks::MockVerifier.should_receive(:verify!).ordered

        example.run
      end

      it "resets all message expectations before running the block" do
        example = Example.new("docstring") do
          
        end
        Stendhal::Mocks::MockVerifier.should_receive(:reset!)
        example.should_receive(:instance_eval).ordered

        example.run
      end

    end

    describe "#fail" do
      it 'fails with a given message' do
        example = Example.new("docstring") do
          fail "expectation not awesome enough"
        end
        example.run
        example.should be_failed
        example.failed_message.should == "expectation not awesome enough"
      end
    end

    describe "class methods" do
      describe "#count" do
        it "returns the number of examples in memory" do
          Example.new("pending")
          Example.count.should == 1
        end
      end
    end

  end
end
