require 'indoctrinatr/tools/configuration_extractor'
require 'indoctrinatr/tools/pdf_generator'
require 'fileutils'

module Indoctrinatr
  module Tools
    class TemplatePackDefaultValuesCompiler
      include TemplatePackHelpers
      include PdfGenerator

      attr_accessor :template_pack_name

      def initialize template_pack_name, keep_aux_files = false
        @template_pack_name = template_pack_name
        @keep_aux_files = keep_aux_files
      end

      def call
        check_for_folder
        compile_tex_file
        rename_if_necessary
      end

      def pdf_exists?
        check_for_folder
        file_path = pdf_with_default_values_file_path ConfigurationExtractor.new(template_pack_name).call
        File.exist? file_path
      end

      private

      def compile_tex_file
        make_pdf tex_with_default_values_file_path, pack_documentation_examples_dir_path, !@keep_aux_files
      end

      def rename_if_necessary # rubocop:disable Metrics/AbcSize
        configuration = ConfigurationExtractor.new(template_pack_name).call # TODO: avoid repeated calling of the ConfigurationExtrator
        @default_values = DefaultValues.new configuration
        return if @default_values.customized_output_file_name == @default_values.default_file_name

        custom_filepath = pack_documentation_examples_dir_path + @default_values.customized_output_file_name
        FileUtils.rm custom_filepath if File.exist? custom_filepath
        FileUtils.mv(pack_documentation_examples_dir_path + @default_values.default_file_name, custom_filepath)
      end
    end
  end
end
