module Indoctrinatr
  module Tools
    module Commands
      class Version < Dry::CLI::Command
        desc 'Print installed version of indoctrinatr-tools.'

        def call(*)
          puts Indoctrinatr::Tools::VERSION
        end
      end
    end
  end
end
