require 'indoctrinatr/tools/template_pack_helpers'
require 'indoctrinatr/tools/field_name_values'
require 'indoctrinatr/tools/configuration_extractor'
require 'indoctrinatr/tools/pdf_generator'
require 'erubis'
require 'to_latex'

module Indoctrinatr
  module Tools
    class TemplatePackFieldnamesCreator
      include TemplatePackHelpers
      include PdfGenerator
      include Dry::Transaction

      step :setup
      step :check_setup
      step :read_config_file
      step :read_tex_file
      step :parse_tex_file
      step :write_tex_file
      step :result

      def pdf_exists?
        check_for_folder
        File.exist? pdf_with_fieldname_values_file_path
      end

      private

      def setup(template_pack_name:, keep_aux_files:)
        path_name = Pathname.new(Dir.pwd).join template_pack_name
        pack_documentation_dir_path = path_name.join 'doc'
        pack_documentation_examples_dir_path = pack_documentation_dir_path.join('examples')
        tex_with_default_values_file_path = pack_documentation_examples_dir_path.join("#{template_pack_name}_with_default_values.tex")
        tex_with_fieldname_values_file_path = pack_documentation_examples_dir_path.join("#{template_pack_name}_with_fieldname_values.tex")
        Success(
          {
            template_pack_name:,
            path_name:,
            keep_aux_files:,
            pack_documentation_dir_path:,
            pack_documentation_examples_dir_path:,
            tex_with_default_values_file_path:,
            tex_with_fieldname_values_file_path:
          }
        )
      end

      def check_setup(config)
        return Failure('Please specify a template pack name.') if config[:template_pack_name].empty?
        return Failure("A folder with name '#{config[:template_pack_name]}' does not exist.") unless Dir.exist? config[:path_name] # rub

        Success(config)
      end

      def read_config_file(config)
        configuration = ConfigurationExtractor.new(config[:template_pack_name]).call
        field_name_values = FieldNameValues.new configuration
        field_name_values._field_names_as_values
        config[:field_name_values] = field_name_values
        Success(config)
      end

      def read_tex_file(config)
        tex_file_path = config[:path_name].join("#{config[:template_pack_name]}.tex.erb")
        config[:tex_file_content] = File.read tex_file_path
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def parse_tex_file(config)
        config[:parsed_tex_file_content] = Erubis::Eruby.new(config[:tex_file_content]).result(config[:field_name_values].retrieve_binding)
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def write_tex_file(config)
        # Create directory to avoid file creation errors
        FileUtils.mkdir_p(config[:pack_documentation_dir_path])
        FileUtils.mkdir_p(config[:pack_documentation_examples_dir_path])
        File.write config[:tex_with_fieldname_values_file_path], config[:parsed_tex_file_content]
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def result(config)
        make_pdf config[:tex_with_fieldname_values_file_path], config[:pack_documentation_examples_dir_path], cleanup: !config[:keep_aux_files]
      rescue StandardError => e
        puts 'possible LaTeX compilation failure!' # see #{latex_log_file_destination} for details. " # idea: process $CHILD_STATUS
        # FileUtils.copy_file latex_log_file, latex_log_file_destination
        Failure(e.message)
      else
        puts "The template pack '#{config[:template_pack_name]}' has been successfully parsed with the variable names"
        puts 'Please check the .tex file and modify it to your needs and compile it again'
        Success()
      end
    end
  end
end
