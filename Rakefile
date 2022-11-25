require 'bundler/gem_tasks'

require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')
task default: :spec

require 'cucumber'
require 'cucumber/rake/task'

desc 'Start up IRB session with Indoctrinatr Tools loaded'
task :console do
  exec 'irb -r indoctrinatr/tools -I ./lib'
end

desc 'Run demo'
task :demo do
  puts `exe/indoctrinatr new demo`
  puts `exe/indoctrinatr parse demo`
  puts `exe/indoctrinatr pdf demo`
  puts `exe/indoctrinatr doc demo`
  puts `exe/indoctrinatr pack demo`
end
