module Indoctrinatr
  module Tools
    module Commands
      class Pack < Dry::CLI::Command
        desc 'Create a Template Pack from a given source folder'

        argument :template_pack_name, desc: 'Name of template pack'

        def call(template_pack_name:, **)
          template_pack_name = CommandAutocompleteHelpers.handle_autocomplete(template_pack_name)

          TemplatePackPacker.new.call(template_pack_name) do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
            end
          end
        end
      end
    end
  end
end
