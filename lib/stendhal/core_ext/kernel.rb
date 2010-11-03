module Kernel
  def describe(*args,&blk)
    if self.is_a? Stendhal::ExampleGroup
      self.add_example_group(*args,&blk)
    else
      Stendhal::ExampleGroup.new(*args,&blk)
    end
  end
  alias_method :context, :describe

  def must(matcher)
    matcher.match self
  end
  def must_not(matcher)
    matcher.match self, :negative => true
  end
end
