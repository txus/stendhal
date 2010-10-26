

ARGV.each do |file|
  require File.join('.',file)
end

examples, failures = Stendhal::Example.run_all
puts "#{examples} #{examples != 1 ? 'examples' : 'example'}, #{failures} #{failures != 1 ? 'failures' : 'failure'}"

