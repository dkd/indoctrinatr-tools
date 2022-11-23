module Indoctrinatr
  module Tools
    module Commands
      class Pdf < Dry::CLI::Command
        desc 'Compile PDF with default values'

        argument :template_pack_name, desc: 'Name of template pack'
        option :keep_aux_files, default: 'false', values: %w[true false], desc: 'The option to keep aux files'

        def call(template_pack_name:, **options)
          TemplatePackDefaultValuesParser.new.call(template_pack_name) do |result|
            result.success do
            end
            result.failure do |message|
              puts message
              return
            end
          end
          keep_aux_files = options.fetch(:keep_aux_files) == 'true'
          TemplatePackDefaultValuesCompiler.new.call(template_pack_name:, keep_aux_files:) do |result|
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
