# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'becoming/version'

Gem::Specification.new do |spec|
  spec.name          = "becoming"
  spec.version       = Becoming::VERSION
  spec.authors       = ["Steve Klabnik"]
  spec.email         = ["steve@steveklabnik.com"]
  spec.description   = %q{Better delegators for Ruby 2.0. Allow your objects to have 'becomings,' temporarily giving them different functionality.}
  spec.summary       = %q{A better way to do delegation.}
  spec.homepage      = "https://github.com/steveklabnik/becoming"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
