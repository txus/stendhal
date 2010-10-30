module Stendhal
  module Matchers
    def ==(other)
      Stendhal::Expectations::EqualityExpectation.new(other)
    end
    def eq(other)
      Stendhal::Expectations::EqualityExpectation.new(other)
    end
    def be_a(kind)
      Stendhal::Expectations::KindExpectation.new(kind)
    end
    def method_missing(m,*args)
      if m.to_s =~ /be_(\w+)/
        Stendhal::Expectations::PredicateExpectation.new(($1 + '?').to_sym)
      end
    end
  end
end
