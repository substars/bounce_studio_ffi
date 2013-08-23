# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bounce_studio_ffi/version'

Gem::Specification.new do |spec|
  spec.name          = "bounce_studio_ffi"
  spec.version       = BounceStudioFfi::VERSION
  spec.authors       = ["Benjamin Ortega"]
  spec.email         = ["ben.ortega@gmail.com"]
  spec.description   = %q{Ruby BounceStudio API for Linux}
  spec.summary       = %q{FFI wrapper for Ruby BounceStudio API for Linux}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "ffi"
  spec.add_development_dependency "activesupport"  
end
