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

