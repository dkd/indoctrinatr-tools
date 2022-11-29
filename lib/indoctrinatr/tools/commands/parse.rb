module Indoctrinatr
  module Tools
    module Commands
      class Parse < Dry::CLI::Command
        desc 'Parse XeTeX file with ERB and default values of Template Pack'

        argument :template_pack_name, desc: 'Name of template pack'

        def call(template_pack_name:, **)
          template_pack_name = CommandAutocompleteHelpers.handle_autocomplete(template_pack_name)

          TemplatePackDefaultValuesParser.new.call(template_pack_name) do |result|
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
