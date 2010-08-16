require 'rubygems'
require 'rake'
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'spec/**/*_test.rb'
  t.verbose = true
end

task :default => [:spec, :test]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "houdini-rails"
    gem.summary = %Q{Rails engine for interacting with the Houdini Mechanical Turk API}
    gem.description = %Q{Rails engine for interacting with the Houdini Mechanical Turk API}
    gem.email = "chris@chrisconley.me"
    gem.homepage = "http://github.com/chrisconley/houdini-rails"
    gem.authors = ["Chris Conley"]
    gem.add_development_dependency "spec", ">= 1.3.0"
    gem.add_dependency "tilt", ">= 1.0.1"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end