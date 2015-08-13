require 'indoctrinatr/tools/template_pack_configuration'
require 'indoctrinatr/tools/directory_helpers'

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
        read_template_files_content
      end

      def retrieve_binding
        binding
      end

      def read_template_files_content
        filenames = list_files_of_type template_pack_name
        @files = []
        filenames.each do |filename| # create array of hashes
          language = get_programming_language filename
          @files << { name: filename, content: File.read(filename), language: language }
        end
        @files
      end
    end
  end
end
