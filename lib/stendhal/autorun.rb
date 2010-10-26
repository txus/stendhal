

ARGV.each do |file|
  require File.join('.',file)
end

Stendhal::Example.run_all
