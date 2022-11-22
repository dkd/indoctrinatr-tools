require_relative 'commands/version'
require_relative 'commands/scaffold'
require_relative 'commands/parse'
require_relative 'commands/pdf'
require_relative 'commands/pdf_with_field_names'
require_relative 'commands/doc'
require_relative 'commands/check'
require_relative 'commands/workflow'
require_relative 'commands/pack'
require_relative 'commands/demo'

module Indoctrinatr
  module Tools
    module Commands
      extend Dry::CLI::Registry

      register 'version', Version, aliases: %w[v -v --version]
      register 'new', Scaffold
      register 'parse', Parse
      register 'pdf', Pdf
      register 'pdf_with_field_names', PdfWithFieldNames
      register 'doc', Doc
      register 'check', Check
      register 'workflow', Workflow
      register 'pack', Pack
      register 'demo' , Demo
    end
  end
end

