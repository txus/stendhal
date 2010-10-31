module Kernel
  def describe(*args,&blk)
    Stendhal::ExampleGroup.new(*args,&blk)
  end
  def must(matcher)
    matcher.match self
  end
  def must_not(matcher)
    matcher.match self, :negative => true
  end
end
