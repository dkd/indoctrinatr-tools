require 'indoctrinatr/tools/default_values'

module Indoctrinatr
  module Tools
    # classes that use this model are required to have template_pack_name as instance variable
    module TemplatePackHelpers
      def path_name
        Pathname.new(Dir.pwd).join template_pack_name
      end

      def assets_path
        path_name.join 'assets'
      end

      def check_for_folder
        fail 'Please specify a template pack name.' if template_pack_name.empty? # rubocop:disable Style/SignalException
        fail "A folder with name '#{template_pack_name}' does not exist." unless Dir.exist? path_name # rubocop:disable Style/SignalException
      end

      def config_file_path
        path_name.join 'configuration.yaml'
      end

      def tex_file_path
        path_name.join template_pack_name + '.tex.erb'
      end

      def tex_with_default_values_file_path
        pack_documentation_examples_dir_path.join template_pack_name + '_with_default_values.tex'
      end

      # get file path for PDF example with default values:
      def pdf_with_default_values_file_path configuration # rubocop:disable Metrics/AbcSize
        default_values = DefaultValues.new configuration
        # if there is a change in where the pdf command (DefaultValuesCompiler) saves it's output, this logic needs to be updated
        if default_values.customized_output_file_name == default_values.default_file_name
          Pathname.new(Dir.pwd).join pack_documentation_examples_dir_path + default_values.customized_output_file_name
        else
          Pathname.new(Dir.pwd).join pack_documentation_examples_dir_path + eval('"' + default_values.output_file_name + '"') # rubocop:disable Security/Eval
          # usage of eval to execute the interpolation of a custom filename string with interpolation - e.g. a filename with the current date
        end
      end

      def pdf_with_fieldname_values_file_path
        "#{pack_documentation_examples_dir_path.join template_pack_name}_with_fieldname_values.pdf"
      end

      def tex_with_fieldname_values_file_path
        "#{pack_documentation_examples_dir_path.join template_pack_name}_with_fieldname_values.tex"
      end

      def pack_documentation_dir_path
        path_name.join 'doc'
      end

      def pack_documentation_examples_dir_path
        pack_documentation_dir_path.join 'examples'
      end

      def pack_technical_documentation_file_path
        pack_documentation_dir_path.join template_pack_name + '_technical_documentation.pdf'
      end

      def latex_log_file_destination
        path_name.join template_pack_name + 'documentation_latex_failure.log'
      end
    end
  end
end
