# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stendhal/version"

Gem::Specification.new do |s|
  s.name        = "stendhal"
  s.version     = Stendhal::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josep M. Bach"]
  s.email       = ["josep.m.bach@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/stendhal"
  s.summary     = %q{Stendhal is a really simple test framework.}
  s.description = %q{Stendhal is a really simple test framework.}

  s.rubyforge_project = "stendhal"
  s.default_executable = "stendhal"

  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "cucumber", "=0.8.5"
  s.add_development_dependency "aruba"

  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-stendhal"
  s.add_development_dependency "growl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
