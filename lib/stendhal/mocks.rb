require 'stendhal/mocks/test_double'
require 'stendhal/mocks/mock_verifier'
require 'stendhal/mocks/stubbable'
require 'stendhal/mocks/mockable'

module Stendhal
  module Mocks
    def double(*args)
      TestDouble.new(*args)
    end
    alias_method :fake, :double
  end
end
