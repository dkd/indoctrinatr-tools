module Indoctrinatr
  module Tools
    module Commands
      class BashCompletions < Dry::CLI::Command
        desc 'Print a guide how to add indoctrinatr-tools integration to .bashrc.'

        def call(**)
          puts <<~HEREDOC
            Add this to your .bashrc (and open up a new shell):

            complete -F get_indoctrinatr_targets indoctrinatr
            function get_indoctrinatr_targets()
            {
              COMPREPLY=(`indoctrinatr completions`)
            }
          HEREDOC
        end
      end
    end
  end
end
