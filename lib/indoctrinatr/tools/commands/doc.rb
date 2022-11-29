module Indoctrinatr
  module Tools
    module Commands
      class Doc < Dry::CLI::Command
        desc 'Create a documentation from a given source folder'

        argument :template_pack_name, desc: 'Name of template pack'
        option :keep_aux_files, type: :boolean, default: 'false', desc: 'The option to keep aux files'

        def call(template_pack_name:, **options)
          template_pack_name = CommandAutocompleteHelpers.handle_autocomplete(template_pack_name)
          keep_aux_files = options.fetch(:keep_aux_files)

          TemplatePackDocumentation.new.call(template_pack_name:, keep_aux_files:) do |result|
            result.success do
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
