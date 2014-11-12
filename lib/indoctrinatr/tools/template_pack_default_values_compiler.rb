require 'indoctrinatr/tools/configuration_extractor'
require 'fileutils'

module Indoctrinatr
  module Tools
    class TemplatePackDefaultValuesCompiler
      include TemplatePackHelpers

      attr_accessor :template_pack_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call
        check_for_folder
        compile_tex_file
        rename_if_necessary
      end

      private

      def compile_tex_file
        args = ['-shell-escape', '-interaction', 'batchmode', tex_with_default_values_file_path.to_s]
        2.times { system('xelatex', *args) }
      end

      def rename_if_necessary
        configuration = ConfigurationExtractor.new(template_pack_name).call
        @default_values = DefaultValues.new configuration
        return if @default_values.customized_output_file_name == @default_values.default_file_name

        FileUtils.rm @default_values.customized_output_file_name if File.exist? @default_values.customized_output_file_name
        FileUtils.mv(@default_values.default_file_name, @default_values.customized_output_file_name)
      end
    end
  end
end
