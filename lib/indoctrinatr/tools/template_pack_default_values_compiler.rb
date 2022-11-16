require 'indoctrinatr/tools/configuration_extractor'
require 'indoctrinatr/tools/pdf_generator'
require 'fileutils'

module Indoctrinatr
  module Tools
    class TemplatePackDefaultValuesCompiler
      include TemplatePackHelpers
      include PdfGenerator
      include Dry::Transaction

      step :check_for_folder
      step :check_setup
      step :compile_tex_file
      step :rename_if_necessary

      def pdf_exists?(template_pack_name)
        check_for_folder
        file_path = pdf_with_default_values_file_path ConfigurationExtractor.new(template_pack_name).call
        File.exist? file_path
      end

      private

      def setup(template_pack_name, keep_aux_files)
        path_name = Pathname.new(Dir.pwd).join template_pack_name
        pack_documentation_dir_path = path_name.join 'doc'
        pack_documentation_examples_dir_path = pack_documentation_dir_path.join('examples')
        tex_with_default_values_file_path = pack_documentation_examples_dir_path.join(template_pack_name + '_with_default_values.tex')
        Success(
          {
            template_pack_name: template_pack_name,
            path_name: path_name,
            keep_aux_files: keep_aux_files,
            pack_documentation_examples_dir_path: pack_documentation_examples_dir_path,
            tex_with_default_values_file_path: tex_with_default_values_file_path
          }
        )
      end
      def check_setup(config)
        return Failure('Please specify a template pack name.') if config[:template_pack_name].empty? # rubocop:disable Style/SignalException
        return Failure ("A folder with name '#{config[:template_pack_name]}' does not exist.") unless Dir.exist? config[:path_name]# rub
        Success(config)
      end
      def compile_tex_file(config)
        make_pdf config[:tex_with_default_values_file_path], config[:pack_documentation_examples_dir_path], !config[:keep_aux_files]
        Success(config)
      end

      def rename_if_necessary(config) # rubocop:disable Metrics/AbcSize
        configuration = ConfigurationExtractor.new(config[:template_pack_name]).call # TODO: avoid repeated calling of the ConfigurationExtrator
        @default_values = DefaultValues.new configuration
        return if @default_values.customized_output_file_name == @default_values.default_file_name

        custom_filepath = config[:pack_documentation_examples_dir_path] + @default_values.customized_output_file_name
        FileUtils.rm custom_filepath if File.exist? custom_filepath
        FileUtils.mv(pack_documentation_examples_dir_path + @default_values.default_file_name, custom_filepath)
        Success()
      end
    end
  end
end
