

ARGV.each do |file|
  require File.join('.',file)
end

examples, failures, pending = Stendhal::Example.run_all
report = "\n#{examples} #{examples != 1 ? 'examples' : 'example'}, #{failures} #{failures != 1 ? 'failures' : 'failure'}"
report += ", #{pending} pending" if pending > 0
puts report

