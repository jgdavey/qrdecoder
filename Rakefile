require 'rake/extensiontask'
require "rspec/core/rake_task"

Rake::ExtensionTask.new('qrdecoder_ext') do |ext|
  ext.lib_dir = 'lib/qrdecoder'
end

RSpec::Core::RakeTask.new

task :default => [:clean, :compile, :spec]

gem 'rdoc'
require 'rdoc/task'
RDoc::Task.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  rd.rdoc_dir = "doc"
end
