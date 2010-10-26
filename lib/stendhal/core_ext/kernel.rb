module Kernel
  def it(*args,&blk)
    Stendhal::Example.new(*args,&blk)
  end
  def pending(*args,&blk)
    if args.last.is_a? Hash
      args.last.update(:pending => true)
    else
      args << {:pending => true}
    end
    Stendhal::Example.new(*args,&blk)
  end
end
