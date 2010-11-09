require 'spec_helper'

module Stendhal
  module Mocks
    describe TestDouble do

      subject { TestDouble.new('double') }

      it 'is created with a name' do
        subject.name.should == 'double'
      end

      context "when given a hash of stubs" do

        subject { TestDouble.new('double', :my_stub => 3) }

        it 'assigns them to the test double' do
          subject.should respond_to(:my_stub)
        end

        it 'makes every stub return its value' do
          subject.my_stub.should == 3
        end

        context "when giving arguments to the subbed method" do

          it 'ignores them' do
            subject.my_stub("argument").should == 3
          end

        end

      end

    end
  end
end
