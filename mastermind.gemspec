# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "mastermind"
  spec.version       = '1.0'
  spec.authors       = ["Chris Swanson"]
  spec.email         = ["TenSaga.Dev@gmail.com"]
  spec.summary       = %q{Short summary of your project}
  spec.description   = %q{Longer description of your project.}
  spec.homepage      = "http://domainforproject.com/"
  spec.license       = "MIT"

  spec.files         = ['lib/mastermind.rb']
  spec.executables   = ['bin/mastermind']
  spec.test_files    = ['tests/test_mastermind.rb']
  spec.require_paths = ["lib"]
end
