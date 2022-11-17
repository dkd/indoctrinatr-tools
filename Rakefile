require 'bundler/gem_tasks'

require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')
task default: :spec

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = 'features --format pretty'
end

desc 'Start up IRB session with Indoctrinatr Tools loaded'
task :console do
  exec 'irb -r indoctrinatr/tools -I ./lib'
end

desc 'Run demo'
task :demo do
  puts `bin/indoctrinatr new demo`
  puts `bin/indoctrinatr parse demo`
  puts `bin/indoctrinatr pdf demo`
  puts `bin/indoctrinatr doc demo`
  puts `bin/indoctrinatr pack demo`
end
