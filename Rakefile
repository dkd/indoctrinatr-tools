require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new("spec")

task default: :spec

desc 'Start up IRB session with Indoctrinatr Tools loaded'
task :console do
  exec "irb -r indoctrinatr/tools -I ./lib"
end