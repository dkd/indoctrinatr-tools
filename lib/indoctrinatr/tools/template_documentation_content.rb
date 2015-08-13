require 'indoctrinatr/tools/template_pack_configuration'
require 'indoctrinatr/tools/directory_helpers'
require 'indoctrinatr/tools/template_documentation_source_file'

module Indoctrinatr
  module Tools
    class TemplateDocumentationContent
      include DirectoryHelpers

      attr_accessor :template_pack_name, :list_of_files

      def initialize template_pack_name, configuration
        @template_pack_name = template_pack_name
        @list_of_files = print_dirtree_style @template_pack_name
        @attributes = configuration.attributes_as_hashes_in_array # we need: name, presentation, default_value, description
        @template_name = configuration.template_name
        @files = read_template_files_content
      end

      def retrieve_binding
        binding
      end

      def read_template_files_content
        filenames = list_files_of_type template_pack_name
        filenames.inject [] do |files, filename|
          files.push TemplateDocumentationSourceFile.new filename
        end
      end
    end
  end
end
