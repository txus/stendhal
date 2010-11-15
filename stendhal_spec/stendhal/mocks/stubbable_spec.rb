class MyArray < Array
  include Stendhal::Mocks::Stubbable
end

module Stendhal
  module Mocks
    describe "a Stubbable class" do

      describe "#stubs" do
        it 'stubs an existing method and makes it return nil' do
          subject = MyArray.new([1,2,3])

          subject.stubs(:length) 
          subject.length.must be_nil
        end
        it 'stubs an unexisting method and makes it return nil' do
          subject = MyArray.new([1,2,3])

          subject.stubs(:w00t) 
          subject.w00t.must be_nil
        end
        it 'saves the unstubbed method' do
          subject = MyArray.new([1,2,3])

          subject.stubs(:length) 
          subject.respond_to?(:__unstubbed_length).must be_true
          subject.send(:__unstubbed_length).must eq(3)
        end
        context "with a block" do
          it 'makes the stub return the result of the block' do
            subject = MyArray.new([1,2,3])

            subject.stubs(:w00t) { 3 + 4 }
            subject.w00t.must eq(7)
          end
        end
      end

    end
  end
end
