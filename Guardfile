# A sample Guardfile
# More info at http://github.com/guard/guard#readme

guard 'rspec', :version => 2, :bundler => true do
  watch('^spec/(.*)_spec.rb')
  watch('^lib/(.*)\.rb')                              { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('^spec/spec_helper.rb')                       { "spec" }
  
  # Rails example
  # watch('^app/(.*)\.rb')                              { |m| "spec/#{m[1]}_spec.rb" }
  watch('^lib/(.*)\.rb')                              { |m| "spec/#{m[1]}_spec.rb" }
  watch('^config/routes.rb')                          { "spec/routing" }
  watch('^app/controllers/application_controller.rb') { "spec/controllers" }
  watch('^spec/factories/(.*)\.rb')                         { "spec/models" }
end if nil

guard 'stendhal' do
  watch('^stendhal_spec/(.*)_spec.rb')
  watch('^lib/(.*)\.rb')                              { |m| "stendhal_spec/#{m[1]}_spec.rb" }
  watch('^stendhal_spec/spec_helper.rb')                       { "stendhal_spec" }
end
