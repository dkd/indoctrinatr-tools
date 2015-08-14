require 'indoctrinatr/tools/template_pack_helpers'
require 'indoctrinatr/tools/template_documentation_helpers'
require 'indoctrinatr/tools/directory_helpers'
require 'indoctrinatr/tools/default_values'
require 'indoctrinatr/tools/configuration_extractor'
require 'erubis'
require 'to_latex'

module Indoctrinatr
  module Tools
    class TemplatePackDocumentation
      # include TemplatePackHelpers
      include TemplateDocumentationHelpers
      # include DirectoryHelpers

      attr_accessor :template_pack_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
        @mydir = DirectoryHelpers.new
      end

      def call
        read_config_file
        read_template_files_content
        read_content_tex_file
        read_main_tex_file
        parse_content_tex_file
        parse_main_tex_file
        write_tex_file
        write_main_tex_file
        copy_source_files
        compile_documentation_to_pdf
        show_success
      end

      private

      def read_config_file
        @configuration = ConfigurationExtractor.new(@template_pack_name).call
        @attributes = @configuration.attributes_as_hashes_in_array # we need: name, presentation, default_value, description
        # TODO: attributes have a required boolean field
        @template_name = 'hardcoded default Name' # stub, should be read from configuration
      end

      def read_template_files_content
        filenames = @mydir.list_files_of_type @template_pack_name
        @files = []
        filenames.each do |filename| # create array of hashes
          language = @mydir.get_programming_language filename
          @files << { name: filename, content: File.read(filename), language: language }
        end
        @files
      end

      def read_content_tex_file
        @content_tex_file_content = File.read content_tex_file_path
      end

      def read_main_tex_file
        @main_tex_file_content = File.read source_main_tex_file_path
      end

      def parse_content_tex_file
        @parsed_tex_file_content = Erubis::Eruby.new(@content_tex_file_content).result(binding)
      end

      def parse_main_tex_file
        @parsed_main_tex_file_content = Erubis::Eruby.new(@main_tex_file_content).result(binding)
      end

      def write_tex_file
        File.write 'indoctrinatr-technical-documentation-content.tex', @parsed_tex_file_content
      end

      def write_main_tex_file
        File.write 'indoctrinatr-technical-documentation.tex', @parsed_main_tex_file_content
      end

      def copy_source_files
        FileUtils.copy_file source_latex_package_file_path, latex_package_destination_path
        FileUtils.copy_file source_letterpaper_file_path, letterpaper_file_destination_path
      end

      def compile_documentation_to_pdf
        args = ['-xelatex', documentation_file_path.to_s] # idea: latexmk  '-interaction=batchmode'
        system('latexmk', *args)
      end

      # TODO: delete copied files, cleanup (latexmk -c)

      def show_success
        puts "A documentation for '#{@template_pack_name}' has been successfully generated."
      end
    end
  end
end
