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
        if compile_documentation_to_pdf
          show_success
        else
          handle_latex_error
        end
        # TODO: rename if necessary?
        # TODO: delete the tex file?
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
        # TODO: include dkd-image-tools.sty and copy them to the doc directory
        File.write tex_with_fieldname_values_file_path, parsed_tex_file_content
      end

      def compile_documentation_to_pdf
        args = ['-xelatex',
                '-shell-escape',
                '-interaction=batchmode', # more silent output
                # "-output-directory=#{documentation_compile_dir_path_name}",  # without this xelatex tries to use the current working directory
                tex_with_fieldname_values_file_path.to_s]
        latexmk_successful = system('latexmk', *args) # latexmk instead of running 2.times
        latexmk_successful # false if error, nil if system command unknown
      end

      def handle_latex_error
        puts 'possible LaTeX compilation failure!' # see #{latex_log_file_destination} for details. " # idea: process $CHILD_STATUS
        # FileUtils.copy_file latex_log_file, latex_log_file_destination
      end

      def show_success
        puts "The template pack '#{template_pack_name}' has been successfully parsed to use the variable names"
      end
    end
  end
end
