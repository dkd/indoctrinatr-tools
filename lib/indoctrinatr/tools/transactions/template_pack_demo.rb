require 'dry/transaction'

module Indoctrinatr
  module Tools
    module Transactions
      class TemplatePackDemo
        include Dry::Transaction

        step :scaffold
        step :parse
        step :pdf
        step :pdf_with_field_names
        step :doc
        step :pack

        private

        def scaffold(template_pack_name)
          TemplatePackScaffold.new.call(template_pack_name) do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
              exit 1
            end
          end
          Success(template_pack_name)
        end

        def parse(template_pack_name)
          Indoctrinatr::Tools::Transactions::TemplatePackDefaultValuesParser.new.call(template_pack_name) do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
              exit 1
            end
          end
          Success(template_pack_name)
        end

        def pdf(template_pack_name)
          TemplatePackDefaultValuesCompiler.new.call(template_pack_name:, keep_aux_files: false) do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
              exit 1
            end
          end
          Success(template_pack_name)
        end

        def pdf_with_field_names(template_pack_name)
          TemplatePackFieldnamesCreator.new.call(template_pack_name:, keep_aux_files: false) do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
              exit 1
            end
          end
          Success(template_pack_name)
        end

        def doc(template_pack_name)
          TemplatePackDocumentation.new.call(template_pack_name:, keep_aux_files: false) do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
              exit 1
            end
          end
          Success(template_pack_name)
        end

        def pack(template_pack_name)
          TemplatePackPacker.new.call(template_pack_name) do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
              exit 1
            end
          end
          Success()
        end
      end
    end
  end
end
