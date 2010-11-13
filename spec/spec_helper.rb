$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'

require 'simplecov'
SimpleCov.start do
  add_group "Root lib" do |src_file|
    src_file.filename =~ /lib\/(\w)+\.rb$/ || (src_file.filename =~ /lib\/stendhal\/(\w)+\.rb$/ && !(src_file.filename =~ /matchers|mocks/))
  end
  add_group "Matchers" do |src_file|
    src_file.filename =~ /lib\/stendhal\/matchers\.rb/ || src_file.filename =~ /lib\/stendhal\/matchers\/(\w)+\.rb$/
  end
  add_group "Mocks" do |src_file|
    src_file.filename =~ /lib\/stendhal\/mocks\.rb/ || src_file.filename =~ /lib\/stendhal\/mocks\/(\w)+\.rb$/
  end
  add_group "Core extensions" do |src_file|
    src_file.filename =~ /lib\/stendhal\/core_ext\/(\w)+\.rb$/
  end
  add_filter '/spec/'
end

require 'stendhal'
require 'rspec'
require 'rspec/autorun'
