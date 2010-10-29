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
      describe "#count" do
        it "returns the number of examples in memory" do
          Example.new("pending")
          Example.count.should == 1
        end
      end
    end

  end
end
