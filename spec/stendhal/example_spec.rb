require 'spec_helper'

module Stendhal
  describe Example do

    before(:each) do
      Example.destroy_all
    end

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
        example.block.should_receive(:call).once

        example.run
      end

      it "captures exceptions" do
        example = Example.new("docstring") do
          raise "error"
        end
        expect {example.run}.to_not raise_error
      end

    end

    describe "class methods" do
      describe "#run_all" do
        it "runs all non-pending examples" do
          runnable_examples = []
          4.times do
            runnable_examples << Example.new("some example") do
              3 + 4
            end
          end
          pending_example = Example.new("pending")

          runnable_examples.each {|e| e.should_receive(:run).once}
          pending_example.should_not_receive(:run)

          Example.run_all
        end
      end
      describe "#count" do
        it "returns the number of examples in memory" do
          Example.new("pending")
          Example.count.should == 1
        end
      end
    end

  end
end
