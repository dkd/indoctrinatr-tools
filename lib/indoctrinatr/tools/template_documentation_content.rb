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
        @default_values_pdf_path = default_values_example
        @pdf_with_field_names_path = fieldname_values_example
      end

      private

      def read_template_files_content
        filenames = list_files_of_type template_pack_name
        filenames.reject! { |f| f.include?(pack_documentation_examples_dir_path.relative_path_from(Pathname.new(Dir.pwd)).to_s) }
        filenames.inject [] do |files, filename|
          files.push TemplateDocumentationSourceFile.new filename
        end
      end

      def default_values_example
        default_values_compiler = TemplatePackDefaultValuesCompiler.new(template_pack_name)
        unless default_values_compiler.pdf_exists?
          TemplatePackDefaultValuesParser.new(template_pack_name).call
          default_values_compiler.call
        end
        pdf_with_default_values_file_path @configuration
      end

      def fieldname_values_example
        fieldnames_creator = TemplatePackFieldnamesCreator.new(template_pack_name)
        # This gives user the option to customize the FieldNameValues Example that is appended in the documentation
        return pdf_with_fieldname_values_file_path if fieldnames_creator.pdf_exists?

        if fieldnames_creator.call
          puts 'INFO: Example with field names has been automatically generated for the documentation' # More user information and for testing
          pdf_with_fieldname_values_file_path
        else
          puts 'ERROR: Example with field names could not be created and is not included in documentation'
          nil
        end
      end
    end
  end
end
