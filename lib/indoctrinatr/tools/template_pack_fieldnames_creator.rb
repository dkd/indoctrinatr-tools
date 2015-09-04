require 'indoctrinatr/tools/template_pack_helpers'
# require 'indoctrinatr/tools/default_values'
require 'indoctrinatr/tools/field_name_values'
require 'indoctrinatr/tools/configuration_extractor'
require 'erubis'
require 'to_latex'

module Indoctrinatr
  module Tools
    class TemplatePackFieldnamesCreator # TODO: rename to field_names
      include TemplatePackHelpers

      attr_accessor :template_pack_name, :configuration, :field_name_values, :tex_file_content, :parsed_tex_file_content

      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call
        check_for_folder
        read_config_file
        read_tex_file
        parse_tex_file
        write_tex_file
        compile_tex_file
        # TODO: rename if necessary?
        # TODO: delete the tex file?
        show_success
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
        File.write tex_with_fieldname_values_file_path, parsed_tex_file_content
      end

      def compile_tex_file
        args = ['-shell-escape', '-interaction', 'batchmode', tex_with_fieldname_values_file_path.to_s]
        2.times { system('xelatex', *args) } # run two times for proper table-of-contents and page count handling. TODO: use latexmk
      end

      def show_success
        puts "The template pack '#{template_pack_name}' has been successfully parsed to use the variable names"
      end
    end
  end
end
