module Indoctrinatr
  module Tools
    module Commands
      class Bashcompletion < Dry::CLI::Command
        desc 'Print a guide how to add indoctrinatr-tools to .bashrc.'

        def call(*)
          puts <<~HEREDOC
            Add this to your .bashrc (and open up a new shell):
            complete -F get_indoctrinatr_targets indoctrinatr
            function get_indoctrinatr_targets()
            {
                if [ -z $2 ] ; then
                    COMPREPLY=(`indoctrinatr help -c`)
                else
                    COMPREPLY=(`indoctrinatr help -c $2`)
                fi
            }
          HEREDOC
        end
      end
    end
  end
end
