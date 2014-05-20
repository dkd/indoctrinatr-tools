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

  spec.required_ruby_version = "~> 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake",    "~> 10.3.1"
  spec.add_development_dependency "rspec",   "~> 2.14.1"
  spec.add_development_dependency "pry",     "~> 0.9.12"

  spec.add_dependency "gli",                 "~> 2.10.0"
  spec.add_dependency "rubyzip",             "~> 1.1.3"
  spec.add_dependency "erubis",              "~> 2.7.0"
  spec.add_dependency "to_latex"

  spec.requirements << "xelatex"
end
