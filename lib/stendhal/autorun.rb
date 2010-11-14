
 

unless ARGV.empty?
  ARGV.each do |file|
    if Dir["#{file}/*"].empty?
      require File.join('.',file)
    else
      Dir["#{file}/**/*_spec.rb"].entries.each do |entry|
        require File.join('.', entry) 
      end
    end
  end
else
  Dir['spec/**/*_spec.rb'].entries.each do |entry|
    require File.join('.', entry) 
  end
end

examples, failures, pending = Stendhal::ExampleGroup.run_all
report = "#{examples} #{examples != 1 ? 'examples' : 'example'}, #{failures} #{failures != 1 ? 'failures' : 'failure'}"
report += ", #{pending} pending" if pending > 0

Stendhal::Reporter.whitespace
color = failures == 0 ? :green : :red
Stendhal::Reporter.line report, :color => color

