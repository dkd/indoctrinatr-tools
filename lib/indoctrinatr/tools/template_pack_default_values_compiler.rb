require 'fileutils'

module Indoctrinatr
  module Tools
    class TemplatePackDefaultValuesCompiler
      include PdfGenerator
      include Dry::Transaction

      step :setup
      step :check_setup
      step :compile_tex_file
      step :rename_if_necessary

      private

      def setup(template_pack_name:, keep_aux_files:)
        path_name = Pathname.new(Dir.pwd).join template_pack_name
        pack_documentation_dir_path = path_name.join 'doc'
        pack_documentation_examples_dir_path = pack_documentation_dir_path.join('examples')
        tex_with_default_values_file_path = pack_documentation_examples_dir_path.join("#{template_pack_name}_with_default_values.tex")
        Success(
          {
            template_pack_name:,
            path_name:,
            keep_aux_files:,
            pack_documentation_examples_dir_path:,
            tex_with_default_values_file_path:
          }
        )
      rescue StandardError => e
        Failure(e.message)
      end

      def check_setup(config)
        return Failure('Please specify a template pack name.') if config[:template_pack_name].empty?
        return Failure("A folder with name '#{config[:template_pack_name]}' does not exist.") unless Dir.exist? config[:path_name] # rub

        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def compile_tex_file(config)
        make_pdf config[:tex_with_default_values_file_path], config[:pack_documentation_examples_dir_path], cleanup: !config[:keep_aux_files]
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def rename_if_necessary(config) # rubocop:disable Metrics/AbcSize
        configuration = ConfigurationExtractor.new(config[:template_pack_name]).call # TODO: avoid repeated calling of the ConfigurationExtrator
        @default_values = DefaultValues.new configuration
        return Success("The pdf has successfully been created as '#{configuration.output_file_name}.") if @default_values.customized_output_file_name == @default_values.default_file_name

        custom_filepath = config[:pack_documentation_examples_dir_path] + @default_values.customized_output_file_name
        FileUtils.rm_f custom_filepath
        FileUtils.mv(config[:pack_documentation_examples_dir_path] + @default_values.default_file_name, custom_filepath)
        Success("A pdf has successfully been created at '#{custom_filepath}.")
      rescue StandardError => e
        Failure(e.message)
      end
    end
  end
end
