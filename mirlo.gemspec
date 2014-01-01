# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mirlo/version'

Gem::Specification.new do |spec|
  spec.name          = "mirlo"
  spec.version       = Mirlo::VERSION
  spec.authors       = ["Alberto F. Capel"]
  spec.email         = ["afcapel@gmail.com"]
  spec.description   = %q{Machine Learning experiments}
  spec.summary       = %q{Implementation of some Machine Learning algorithms}
  spec.homepage      = "https://github.com/afcapel/mirlo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "gnuplot"
end
