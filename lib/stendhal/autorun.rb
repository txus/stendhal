

ARGV.each do |file|
  require File.join('.',file)
end

examples, failures, pending = Stendhal::ExampleGroup.run_all
report = "#{examples} #{examples != 1 ? 'examples' : 'example'}, #{failures} #{failures != 1 ? 'failures' : 'failure'}"
report += ", #{pending} pending" if pending > 0

Reporter.whitespace
color = failures == 0 ? :green : :red
Reporter.line report, :color => color

