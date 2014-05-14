# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'indoctrinatr/tools/version'

Gem::Specification.new do |spec|
  spec.name          = "indoctrinatr-tools"
  spec.version       = Indoctrinatr::Tools::VERSION
  spec.authors       = ["Nicolai Reuschling"]
  spec.email         = ["nicolai.reuschling@dkd.de"]
  spec.summary       = %q{indoctrinatr-tools provides a set of command line tools for Indoctrinatr (an Open Source Software project by DKD Internet Service GmbH, Frankfurt am Main, Germany.)}
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
