class MyClass
  include Stendhal::Matchers
end

module Stendhal
  describe "a class with included Matchers" do
  
    describe "#eql / #eq" do
      it 'creates a new equality expectation' do
        # Matchers::Equality.should_receive(:new).with(7).twice
        MyClass.new.eq(7).must be_a(Matchers::Equality)
        MyClass.new.eql(7).must be_a(Matchers::Equality)
      end
    end

    describe "#be_a / #be_an" do
      it 'creates a new kind expectation' do
        # Matchers::Kind.should_receive(:new).with(Fixnum)
        MyClass.new.be_a(Fixnum).must be_a(Matchers::Kind)
      end
    end

    describe "#include" do
      it 'creates a new inclusion expectation' do
        # Matchers::Inclusion.should_receive(:new).with(3)
        MyClass.new.include(3).must be_a(Matchers::Inclusion)
      end
    end

    describe "#raise_error" do
      it 'creates a new raise_error expectation' do
        # Matchers::RaiseError.should_receive(:new).with(StandardError)
        MyClass.new.raise_error(StandardError).must be_a(Matchers::RaiseError)
      end
    end

    describe "#be_whatever" do
      it 'creates a new predicate expectation' do
        # Matchers::Predicate.should_receive(:new).with(:frozen?)
        MyClass.new.be_frozen.must be_a(Matchers::Predicate)
      end
    end

  end
end
