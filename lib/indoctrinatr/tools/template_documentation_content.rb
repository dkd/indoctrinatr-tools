require 'indoctrinatr/tools/content_for_tex_files'
require 'indoctrinatr/tools/template_pack_configuration'
require 'indoctrinatr/tools/directory_helpers'
require 'indoctrinatr/tools/template_documentation_source_file'
require 'indoctrinatr/tools/default_values'

module Indoctrinatr
  module Tools
    class TemplateDocumentationContent < ContentForTexFiles
      include DirectoryHelpers
      include TemplatePackHelpers

      attr_accessor :template_pack_name, :list_of_files

      # Overwrite the initialize method because the content is built up much more complex than for the other
      # ContentForTexFile children.
      def initialize template_pack_name, configuration
        @configuration = configuration
        @template_pack_name = template_pack_name
        @list_of_files = print_dirtree_style @template_pack_name
        @attributes = configuration.attributes_as_hashes_in_array # we need: name, presentation, default_value, description
        @template_name = configuration.template_name
        @files = read_template_files_content
        @default_values_pdf_path = pdf_with_default_values_file_path configuration
        # should have been generated automatically or be already existing, error if something went wrong with it:
        fail IOError, "template with default values does not exist in current directory. Run indoctrinatr pdf #{template_pack_name}" unless File.exist? @default_values_pdf_path # rubocop:disable Style/SignalException
      end

      private

      def read_template_files_content
        filenames = list_files_of_type template_pack_name
        filenames.inject [] do |files, filename|
          files.push TemplateDocumentationSourceFile.new filename
        end
      end

      # TODO: get path for PDF with field_names
      # TODO: include PDF with field_names *if* it has been successfully generated
    end
  end
end
