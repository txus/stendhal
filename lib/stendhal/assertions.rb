module Stendhal
  module Assertions
    def assert test, msg = nil
      msg ||= "Failed assertion, no message given."
      unless test then
        raise AssertionFailed, msg
      end
      true
    end
  end
  class AssertionFailed < Exception; end
end
