require_relative '../template_pack_scaffold'

module Indoctrinatr
  module Tools
    module Commands
      class Scaffold < Dry::CLI::Command
        desc 'Scaffold new project'

        argument :template_pack_name, desc: 'Name of template pack'

        def call(template_pack_name: '', **)
          template_pack_name = CommandAutocompleteHelpers.handle_autocomplete(template_pack_name)

          TemplatePackScaffold.new.call(template_pack_name) do |result|
            result.success do
              puts "A template pack scaffold was created in folder '#{template_pack_name}'. Happy templating…"
            end

            result.failure do |message|
              puts message
              exit(1)
            end
          end
        end
      end
    end
  end
end
