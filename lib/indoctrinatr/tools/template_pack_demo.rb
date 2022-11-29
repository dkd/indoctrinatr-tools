module Indoctrinatr
  module Tools
    class TemplatePackDemo
      attr_accessor :template_pack_name

      def initialize(template_pack_name)
        @template_pack_name = template_pack_name
      end

      def call
        new
        parse
        pdf
        pdf_with_field_names
        doc
        pack
      end

      private

      def new
        TemplatePackScaffold.new.call(template_pack_name) do |result|
          result.success do |message|
            puts message
          end

          result.failure do |message|
            puts message
          end
        end
      end

      def parse
        TemplatePackDefaultValuesParser.new.call(template_pack_name) do |result|
          result.success do |message|
            puts message
          end

          result.failure do |message|
            puts message
          end
        end
      end

      def pdf
        TemplatePackDefaultValuesCompiler.new.call(template_pack_name:, keep_aux_files: false) do |result|
          result.success do |message|
            puts message
          end

          result.failure do |message|
            puts message
          end
        end
      end

      def pdf_with_field_names
        TemplatePackFieldnamesCreator.new.call(template_pack_name:, keep_aux_files: false) do |result|
          result.success do |message|
            puts message
          end

          result.failure do |message|
            puts message
          end
        end
      end

      def doc
        TemplatePackDocumentation.new.call(template_pack_name:, keep_aux_files: false) do |result|
          result.success do |message|
            puts message
          end

          result.failure do |message|
            puts message
          end
        end
      end

      def pack
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
