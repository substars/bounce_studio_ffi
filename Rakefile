require "bundler/gem_tasks"
require 'rake/testtask'


desc('Runs all tests in the subdirectories of lib')
task :test do
  Rake::TestTask.new do |t|
    t.libs << 'test'
    t.pattern = 'test/**/*_test.rb'
  end
end
