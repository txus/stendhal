require 'spec_helper'

class MyArray < Array
  include Stendhal::Mocks::Stubbable
end

module Stendhal
  module Mocks
    describe "a Stubbable class" do

      subject { MyArray.new([1,2,3]) }

      describe "#stubs" do
        it 'stubs an existing method and makes it return nil' do
          subject.stubs(:length) 
          subject.length.should be_nil
        end
        it 'stubs an unexisting method and makes it return nil' do
          subject.stubs(:w00t) 
          subject.w00t.should be_nil
        end
        it 'saves the unstubbed method' do
          subject.stubs(:length) 
          subject.should respond_to(:__unstubbed_length)
          subject.send(:__unstubbed_length).should == 3
        end
        context "with a block" do
          it 'makes the stub return the result of the block' do
            subject.stubs(:w00t) { 3 + 4 }
            subject.w00t.should eq(7)
          end
        end
      end

    end
  end
end
