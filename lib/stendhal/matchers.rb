require 'stendhal/matchers/abstract_matcher'
require 'stendhal/matchers/equality'
require 'stendhal/matchers/kind'
require 'stendhal/matchers/predicate'
require 'stendhal/matchers/inclusion'
require 'stendhal/matchers/raise_error'

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
    alias_method :be_an, :be_a

    def include(member)
      Inclusion.new(member)
    end

    def raise_error(*args)
      RaiseError.new(*args)
    end

    def method_missing(m,*args)
      if m.to_s =~ /be_(\w+)/
        Predicate.new(($1 + '?').to_sym)
      else
        super(m,*args)
      end
    end
  end
end
