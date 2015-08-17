require 'indoctrinatr/tools/template_documentation_content'
require 'indoctrinatr/tools/template_pack_helpers'
require 'indoctrinatr/tools/template_documentation_helpers'
require 'indoctrinatr/tools/configuration_extractor'
require 'erubis'
require 'to_latex'
require 'fileutils'

module Indoctrinatr
  module Tools
    class TemplatePackDocumentation
      include TemplatePackHelpers
      include TemplateDocumentationHelpers

      attr_accessor :template_pack_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call
        fill_documentation_content
        read_content_tex_file
        read_main_tex_file
        parse_content_tex_file
        parse_main_tex_file
        create_temp_compile_dir
        write_content_tex_file
        write_main_tex_file
        copy_source_files
        if compile_documentation_to_pdf
          copy_doc_file_to_template_pack
          delete_temp_dir
          show_success
        else
          handle_latex_error
        end
      end

      private

      def fill_documentation_content
        configuration = ConfigurationExtractor.new(template_pack_name).call
        @documentation_content = TemplateDocumentationContent.new template_pack_name, configuration
      end

      def read_content_tex_file
        @content_tex_file_content = File.read content_tex_file_path
      end

      def read_main_tex_file
        @main_tex_file_content = File.read source_main_tex_file_path
      end

      def parse_content_tex_file
        @parsed_content_tex_file_content = Erubis::Eruby.new(@content_tex_file_content).result(@documentation_content.retrieve_binding)
      end

      def parse_main_tex_file
        @parsed_main_tex_file_content = Erubis::Eruby.new(@main_tex_file_content).result(@documentation_content.retrieve_binding)
      end

      def create_temp_compile_dir
        make_documentation_compile_dir_path_name
      end

      def write_content_tex_file
        File.write content_tex_file_destination_path, @parsed_content_tex_file_content
      end

      def write_main_tex_file
        File.write main_tex_file_destination_path, @parsed_main_tex_file_content
      end

      def copy_source_files
        FileUtils.copy_file source_latex_package_file_path, latex_package_destination_path
        FileUtils.copy_file source_letterpaper_file_path, letterpaper_file_destination_path
      end

      def compile_documentation_to_pdf
        args = ['-xelatex',
                '-shell-escape',
                '-interaction=batchmode', # more silent output
                "-output-directory=#{documentation_compile_dir_path_name}", main_tex_file_destination_path.to_s] # without this xelatex tries to use the current working directory
        latexmk_successful = system('latexmk', *args) # latexmk instead of running 2.times
        latexmk_successful # false if error, nil if system command unknown
      end

      def copy_doc_file_to_template_pack
        FileUtils.copy_file documentation_file_path, pack_technical_documentation_file_path
      end

      def delete_temp_dir
        FileUtils.remove_entry_secure documentation_compile_dir_path_name
      end

      def handle_latex_error
        puts "possible LaTeX compilation failure! see #{latex_log_file_destination} for details. " # idea: process $CHILD_STATUS
        FileUtils.copy_file latex_log_file, latex_log_file_destination
      end

      def show_success
        puts "A documentation for '#{template_pack_name}' has been successfully generated."
      end
    end
  end
end
