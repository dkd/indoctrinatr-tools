module Indoctrinatr
  module Tools
    module Commands
      class CompletionCommands < Dry::CLI::Command
        def call(**)
          puts <<~HEREDOC
            bashcompletion
            check
            completions
            demo
            doc
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
