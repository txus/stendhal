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
        example.should_receive(:instance_eval)

        example.run
      end

      it "captures failed assertions" do
        example = Example.new("docstring") do
          assert false
        end
        expect {example.run}.to_not raise_error
        example.run
        example.should be_failed
      end

      it "captures exceptions" do
        example = Example.new("docstring") do
          raise "error"
        end
        expect {example.run}.to_not raise_error
        example.run
        example.should be_aborted
      end

    end

    describe "class methods" do
      describe "#run_all" do
        let(:runnable_examples) do
          examples = []
          4.times do
            examples << Example.new("some example") do
              assert true
            end
          end
          examples
        end

        let(:failing_example) do
          Example.new("failing") do
            assert false
          end
        end

        let(:pending_example) do
          Example.new("pending")
        end

        it "runs all non-pending examples" do
          runnable_examples.each {|e| e.should_receive(:run).once.and_return(0)}
          failing_example.should_receive(:run).once.and_return(1)
          pending_example.should_not_receive(:run)

          Example.run_all
        end

        it "returns an array with total examples and failures" do
          runnable_examples
          failing_example
          pending_example
          Example.run_all.should == [6,1]
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
