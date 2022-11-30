module Indoctrinatr
  module Tools
    module Commands
      class Help < Dry::CLI::Command
        desc '\'help -c\' prints all available commands for indoctrinatr-tools. '

        option :completion, type: :boolean, aliases: ['c'], default: false, desc: 'completion'

        def call(**options)
          if options.fetch(:completion)
            puts <<~HEREDOC
              _doc
              bashcompletion
              check
              demo
              doc
              help
              initconfig
              new
              pack
              parse
              pdf
              pdf_with_field_names
              version
              workflow
              zshcompletion
            HEREDOC
          end
        end
      end
    end
  end
end
