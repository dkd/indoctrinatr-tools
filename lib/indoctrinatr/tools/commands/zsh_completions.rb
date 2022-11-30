module Indoctrinatr
  module Tools
    module Commands
      class ZshCompletions < Dry::CLI::Command
        desc 'Print a guide how to add indoctrinatr-tools integration to .zshrc.'

        def call(**)
          puts <<~HEREDOC
            Add this to your .zshrc (and open up a new shell):

            if [[ -n ${ZSH_VERSION-} ]]; then
              autoload -U +X bashcompinit && bashcompinit
            fi
            complete -F get_indoctrinatr_commands indoctrinatr
            function get_indoctrinatr_commands()
            {
              local binary="indoctrinatr"
              COMPREPLY=(`$binary completions`)
            }
          HEREDOC
        end
      end
    end
  end
end
