require 'indoctrinatr/tools/template_documentation_content'
require 'indoctrinatr/tools/template_pack_helpers'
require 'indoctrinatr/tools/template_documentation_helpers'
require 'indoctrinatr/tools/configuration_extractor'
require 'indoctrinatr/tools/pdf_generator'
require 'erubis'
require 'to_latex'
require 'fileutils'

module Indoctrinatr
  module Tools
    class TemplatePackDocumentation
      include TemplatePackHelpers
      include TemplateDocumentationHelpers
      include PdfGenerator

      attr_accessor :template_pack_name

      def initialize template_pack_name, no_clean_up_after = false
        @template_pack_name = template_pack_name
        @no_clean_up_after = no_clean_up_after
      end

      def call # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
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
          copy_helper_files_to_template_pack if @no_clean_up_after
          show_temp_directory if @no_clean_up_after
          delete_temp_dir unless @no_clean_up_after
          show_success
        else
          copy_helper_files_to_template_pack if @no_clean_up_after
          show_temp_directory if @no_clean_up_after
          handle_latex_error
        end
      end

      private

      def fill_documentation_content
        configuration = ConfigurationExtractor.new(template_pack_name).call
        begin
          @documentation_content = TemplateDocumentationContent.new template_pack_name, configuration
        rescue IOError => ex
          abort ex.message
        end
      end

      def read_content_tex_file
        @content_tex_file_content = File.read content_tex_file_path
      end

      def read_main_tex_file
        @main_tex_file_content = File.read source_main_tex_file_path
      end

      def parse_content_tex_file
        @parsed_content_tex_file_content = Erubis::Eruby.new(@content_tex_file_content).result(@documentation_content.retrieve_binding) # TODO: more useful error messages for user on errors
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
        FileUtils.copy_file source_image_tools_package_file_path, image_tools_package_destination_path
      end

      def compile_documentation_to_pdf
        make_pdf main_tex_file_destination_path, documentation_compile_dir_path_name, !@no_clean_up_after
      end

      def copy_helper_files_to_template_pack
        helper_files_to_copy = [latex_log_file, content_tex_file_destination_path, main_tex_file_destination_path].freeze
        Dir.mkdir(pack_documentation_dir_path) unless Dir.exist?(pack_documentation_dir_path)
        FileUtils.copy helper_files_to_copy, pack_documentation_dir_path
        puts 'TeX files and log file have been copied to doc subdirectory of your template_pack'
      end

      def copy_doc_file_to_template_pack
        # All the documentation shall go into template_pack/doc
        Dir.mkdir(pack_documentation_dir_path) unless Dir.exist?(pack_documentation_dir_path)
        FileUtils.copy_file documentation_file_path, pack_technical_documentation_file_path
      end

      def show_temp_directory
        puts "Look into the directory #{documentation_temp_dir} to see all files related to the technical documentation compilation"
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
