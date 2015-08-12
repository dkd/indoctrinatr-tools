require 'indoctrinatr/tools/template_pack_configuration'
require 'indoctrinatr/tools/directory_helpers'

module Indoctrinatr
  module Tools
    class TemplateDocumentationContent
      attr_accessor :template_pack_name

      def initialize template_pack_name, configuration
        @template_pack_name = template_pack_name
        @mydir = DirectoryHelpers.new
        @attributes = configuration.attributes_as_hashes_in_array # we need: name, presentation, default_value, description
        @template_name = configuration.template_name
        read_template_files_content
      end

      def retrieve_binding
        binding
      end

      def read_template_files_content
        filenames = @mydir.list_files_of_type template_pack_name
        @files = []
        filenames.each do |filename| # create array of hashes
          language = @mydir.get_programming_language filename
          @files << { name: filename, content: File.read(filename), language: language }
        end
        @files
      end
    end
  end
end
