module Kernel
  def describe(*args,&blk)
    Stendhal::ExampleGroup.new(*args,&blk)
  end
end
