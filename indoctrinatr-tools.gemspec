lib = File.expand_path('lib', __dir__)
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

  spec.required_ruby_version = '~> 3.1'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'aruba',     '~> 0.14'
  spec.add_development_dependency 'bundler',   '~> 2.0'
  spec.add_development_dependency 'cucumber',  '~> 3.0'
  spec.add_development_dependency 'pry',       '~> 0.11'
  spec.add_development_dependency 'rake',      '~> 13.0'
  spec.add_development_dependency 'rspec',     '~> 3.7'
  spec.add_development_dependency 'rubocop',   '~> 0.79'
  spec.add_development_dependency 'rubocop-performance', '~> 1.3'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.22'

  spec.add_dependency 'dry-cli',  '~> 0.6'
  spec.add_dependency 'dry-transaction', '~> 0.13'
  spec.add_dependency 'erubis',   '~> 2.7'
  spec.add_dependency 'RedCloth', '~> 4.3'
  spec.add_dependency 'rubyzip',  '~> 2'
  spec.add_dependency 'to_latex', '~> 0.5'

  spec.requirements << 'LaTeX development enviroment'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
