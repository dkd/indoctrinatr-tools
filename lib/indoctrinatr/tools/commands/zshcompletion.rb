module Indoctrinatr
  module Tools
    module Commands
      class Zshcompletion < Dry::CLI::Command
        desc 'Print a guide how to add indoctrinatr-tools to .zshrc.'

        def call(*)
          puts <<~HEREDOC
            Add this to your .zshrc (and open up a new shell):
            if [[ -n ${ZSH_VERSION-} ]]; then
              autoload -U +X bashcompinit && bashcompinit
            fi
            complete -F get_indoctrinatr_commands indoctrinatr
            function get_indoctrinatr_commands()
            {
              local binary="indoctrinatr"
              help_params=${COMP_WORDS[@]:1}
              clean_params=${help_params//-*([^ ])?( )}
              COMPREPLY=(`$binary help -c $clean_params`)
            }
          HEREDOC
        end
      end
    end
  end
end
