# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'indoctrinatr/tools/version'

Gem::Specification.new do |spec|
  spec.name          = 'indoctrinatr-tools'
  spec.version       = Indoctrinatr::Tools::VERSION
  spec.authors       = ['Nicolai Reuschling', 'Luka Lüdicke']
  spec.email         = ['nicolai.reuschling@dkd.de', 'luka.luedicke@dkd.de']
  spec.summary       = 'indoctrinatr-tools provides a set of command line tools for Indoctrinatr (an Open Source Software project by dkd Internet Service GmbH, Frankfurt am Main, Germany).'
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.required_ruby_version = '~> 2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',   '~> 1.13'
  spec.add_development_dependency 'rake',      '~> 11.2'
  spec.add_development_dependency 'rspec',     '~> 3.5'
  spec.add_development_dependency 'cucumber',  '~> 2.4'
  spec.add_development_dependency 'aruba',     '~> 0.14'
  spec.add_development_dependency 'rubocop',   '~> 0.42'
  spec.add_development_dependency 'pry',       '~> 0.10'
  spec.add_development_dependency 'coveralls', '~> 0.8'

  spec.add_dependency 'gli',      '~> 2.12'
  spec.add_dependency 'rubyzip',  '~> 1.1'
  spec.add_dependency 'erubis',   '~> 2.7'
  spec.add_dependency 'to_latex', '~> 0.5'
  spec.add_dependency 'RedCloth', '~> 4.3'

  spec.cert_chain  = ['certs/dkd-reuschling.pem']
  spec.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $PROGRAM_NAME.end_with?('gem')

  spec.requirements << 'LaTeX development enviroment'
end
