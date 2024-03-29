lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'indoctrinatr/tools/version'

Gem::Specification.new do |spec|
  spec.name          = 'indoctrinatr-tools'
  spec.version       = Indoctrinatr::Tools::VERSION
  spec.authors       = ['Nicolai Reuschling', 'Eike Henrich']
  spec.email         = ['nicolai.reuschling@dkd.de', 'eike.henrich@dkd.de']
  spec.summary       = 'indoctrinatr-tools provides a set of command line tools for Indoctrinatr (an Open Source Software project by dkd Internet Service GmbH, Frankfurt am Main, Germany).'
  spec.homepage      = 'https://github.com/dkd/indoctrinatr'
  spec.license       = 'MIT'

  spec.required_ruby_version = '~> 3.1'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'aruba', '~> 2.1'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'cucumber', '~> 8.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.10'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.0'
  spec.add_development_dependency 'simplecov', '~> 0.21'

  spec.add_dependency 'dry-cli', '~> 1.0'
  spec.add_dependency 'dry-transaction', '~> 0.13'
  spec.add_dependency 'erubis', '~> 2.7'
  spec.add_dependency 'RedCloth', '~> 4.3'
  spec.add_dependency 'rubyzip', '~> 2'
  spec.add_dependency 'to_latex', '~> 0.5'
  spec.add_dependency 'zeitwerk', '~> 2.6'

  spec.requirements << 'LaTeX development enviroment'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
