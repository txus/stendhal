require 'spec_helper'

class MyClass < Array
  include Stendhal::Mocks::Spyable
end

module Stendhal
  module Mocks
    describe "a Spyable class" do

      subject { MyClass.new([1,2,3]) }

      it 'acts as a proxy for the target' do
        subject.spy(:length) 
        subject.length
      end

    end
  end
end
