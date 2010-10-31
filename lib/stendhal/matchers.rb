require 'stendhal/matchers/abstract_matcher'
require 'stendhal/matchers/equality'
require 'stendhal/matchers/kind'
require 'stendhal/matchers/predicate'

module Stendhal
  module Matchers
    def eq(other)
      Equality.new(other)
    end
    alias_method :eql, :eq

    def be_a(kind)
      Kind.new(kind)
    end
    alias_method :be_kind_of, :be_a
    alias_method :be_a_kind_of, :be_a

    def method_missing(m,*args)
      if m.to_s =~ /be_(\w+)/
        Predicate.new(($1 + '?').to_sym)
      end
    end
  end
end
