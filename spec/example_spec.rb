require 'spec_helper'

module Stendhal
  describe Example do

    it "is created with a docstring and a block" do
      example = Example.new("docstring") do
        3 + 4
      end
      example.description.should == "docstring"
    end

    it "can be run" do
      example = Example.new("docstring") do
        3 + 4 
      end
      example.run
    end

    it "captures exceptions" do
      example = Example.new("docstring") do
        raise "error"
      end
      expect {example.run}.to_not raise_error
    end

    it "is pending unless given a block" do
      example = Example.new("pending")
      example.should be_pending
    end

  end
end
