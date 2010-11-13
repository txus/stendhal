require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'stendhal'
require 'cucumber/rake/task'

desc "Run the specs under spec"
RSpec::Core::RakeTask.new

desc "Run the specs under stendhal"
Stendhal::RakeTask.new(:stendhal)

Cucumber::Rake::Task.new(:cucumber)

task :default => :stendhal
