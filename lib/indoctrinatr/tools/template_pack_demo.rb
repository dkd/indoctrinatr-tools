module Indoctrinatr
  module Tools
    class TemplatePackDemo
      include TemplatePackHelpers

      attr_accessor :template_pack_name

      def initialize(template_pack_name)
        @template_pack_name = template_pack_name
      end

      def call
        TemplatePackScaffold.new.call(template_pack_name)
        TemplatePackDefaultValuesParser.new.call(template_pack_name)
        TemplatePackDefaultValuesCompiler.new.call(template_pack_name:, keep_aux_files: false)
        TemplatePackDocumentation.new.call(template_pack_name:, keep_aux_files: false)
        TemplatePackPacker.new.call(template_pack_name)
      end
    end
  end
end
