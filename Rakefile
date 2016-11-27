require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/test*.rb']
  #t.pattern = "tests/test*.rb"
  t.verbose = true
  t.warning = false
  task :default => :test
end
