# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mrz/version'

Gem::Specification.new do |spec|
  spec.name          = "mrz"
  spec.version       = Mrz::VERSION
  spec.authors       = ["Kristijonas Urbaitis"]
  spec.email         = ["kristijonas.urbaitis@gmail.com"]
  spec.summary       = %q{Generates MRZ.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
end
