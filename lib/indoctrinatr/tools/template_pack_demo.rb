require 'indoctrinatr/tools/template_pack_helpers'

module Indoctrinatr
  module Tools
    class TemplatePackDemo
      include TemplatePackHelpers

      attr_accessor :template_pack_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call
        TemplatePackScaffold.new(template_pack_name).call
        TemplatePackDefaultValuesParser.new(template_pack_name).call
        TemplatePackDefaultValuesCompiler.new(template_pack_name).call
        TemplatePackPacker.new(template_pack_name).call
        TemplatePackCleaner.new(template_pack_name).call
      end
    end
  end
end
