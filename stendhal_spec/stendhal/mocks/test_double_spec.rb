module Stendhal
  module Mocks
    describe TestDouble do

      it 'is created with a name' do
        subject = TestDouble.new('double')

        subject.name.must eq('double')
      end

      context "when given a hash of stubs" do

        it 'assigns them to the test double' do
          subject = TestDouble.new('double', :my_stub => 3)

          subject.respond_to?(:my_stub).must be_true
        end

        it 'makes every stub return its value' do
          subject = TestDouble.new('double', :my_stub => 3)

          subject.my_stub.must eq(3)
        end

        context "when giving arguments to the stubbed method" do
          it 'ignores them' do
            subject = TestDouble.new('double', :my_stub => 3)

            subject.my_stub("argument").must eq(3)
          end
        end

      end

    end
  end
end
