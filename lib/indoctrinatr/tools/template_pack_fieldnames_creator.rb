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

      attr_accessor :template_pack_name, :configuration, :field_name_values, :tex_file_content, :parsed_tex_file_content

      def initialize template_pack_name, keep_aux_files = false
        @template_pack_name = template_pack_name
        @keep_aux_files = keep_aux_files
      end

      def call
        check_for_folder
        read_config_file
        read_tex_file
        parse_tex_file
        write_tex_file
        if compile_tex_file
          show_success
          true
        else
          handle_latex_error
          false
        end
      end

      def pdf_exists?
        check_for_folder
        File.exist? pdf_with_fieldname_values_file_path
      end

      private

      def read_config_file
        @configuration = ConfigurationExtractor.new(template_pack_name).call
        @field_name_values = FieldNameValues.new @configuration
        field_name_values._field_names_as_values
      end

      def read_tex_file
        @tex_file_content = File.read tex_file_path
      end

      def parse_tex_file
        @parsed_tex_file_content = Erubis::Eruby.new(@tex_file_content).result(field_name_values.retrieve_binding)
      end

      def write_tex_file
        # Create directory to avoid file creation errors
        Dir.mkdir(pack_documentation_dir_path) unless Dir.exist?(pack_documentation_dir_path)
        Dir.mkdir(pack_documentation_examples_dir_path) unless Dir.exist?(pack_documentation_examples_dir_path)
        File.write tex_with_fieldname_values_file_path, parsed_tex_file_content
      end

      def compile_tex_file
        make_pdf tex_with_fieldname_values_file_path, pack_documentation_examples_dir_path, !@keep_aux_files
      end

      def handle_latex_error
        puts 'possible LaTeX compilation failure!' # see #{latex_log_file_destination} for details. " # idea: process $CHILD_STATUS
        # FileUtils.copy_file latex_log_file, latex_log_file_destination
      end

      def show_success
        puts "The template pack '#{template_pack_name}' has been successfully parsed with the variable names"
        puts 'Please check the .tex file and modify it to your needs and compile it again'
      end
    end
  end
end
