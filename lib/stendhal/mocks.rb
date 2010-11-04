require 'stendhal/mocks/test_double'
require 'stendhal/mocks/spyable'

module Stendhal
  module Mocks
    def double(*args)
      TestDouble.new(*args)
    end
    alias_method :fake, :double
  end
end
