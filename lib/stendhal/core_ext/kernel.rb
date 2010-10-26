module Kernel
  def it(*args,&blk)
    Stendhal::Example.new(*args,&blk)
  end
end
