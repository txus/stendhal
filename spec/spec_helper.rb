$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'

require 'simplecov'
SimpleCov.start do
  add_group "Lib", 'lib'
end

require 'stendhal'
require 'rspec'
require 'rspec/autorun'
