require 'rake/extensiontask'
require "rspec/core/rake_task"

Rake::ExtensionTask.new('qrdecoder_ext') do |ext|
  ext.lib_dir = 'lib/qrdecoder'
end

RSpec::Core::RakeTask.new

task :default => [:clean, :compile, :spec]
