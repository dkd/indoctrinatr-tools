module Indoctrinatr
  module Tools
    module Commands
      extend Dry::CLI::Registry

      register 'bashcompletion', BashCompletions
      register 'check', Check
      register 'commands', CompletionCommands
      register 'demo', Demo
      register 'doc', Doc
      register 'new', Scaffold
      register 'pack', Pack
      register 'parse', Parse
      register 'pdf', Pdf
      register 'pdf_with_field_names', PdfWithFieldNames
      register 'version', Version, aliases: %w[v -v --version]
      register 'workflow', Workflow
      register 'zshcompletion', ZshCompletions
    end
  end
end
