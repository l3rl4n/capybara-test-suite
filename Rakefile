require 'rubygems'
require 'rspec/core/rake_task'

desc 'Test the Templates Page'
RSpec::Core::RakeTask.new :templates do |t|
  t.rspec_opts = '--color --format progress'
  t.pattern = 'spec/features/templates_routines.rb'
end

task :default => [:templates]