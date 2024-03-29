module Indoctrinatr
  module Tools
    module Commands
      class Pdf < Dry::CLI::Command
        desc 'Compile PDF with default values.'

        argument :template_pack_name, desc: 'Name of template pack'
        option :keep_aux_files, type: :boolean, default: false, desc: 'The option to keep aux files'

        def call(template_pack_name:, **options)
          template_pack_name = CommandAutocompleteHelpers.handle_autocomplete(template_pack_name)
          keep_aux_files = options.fetch(:keep_aux_files)

          Indoctrinatr::Tools::Transactions::TemplatePackDefaultValuesParser.new.call(template_pack_name) do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
              exit 1
            end
          end

          Indoctrinatr::Tools::Transactions::TemplatePackDefaultValuesCompiler.new.call(template_pack_name:, keep_aux_files:) do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
              exit 1
            end
          end
        end
      end
    end
  end
end
