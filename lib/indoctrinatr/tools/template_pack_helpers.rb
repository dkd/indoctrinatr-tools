module Indoctrinatr
  module Tools
    module TemplatePackHelpers # classes that use this model are required to have template_pack_name as instance variable
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
        path_name.join template_pack_name + '_with_default_values.tex'
      end

      def tex_with_fieldname_values_file_path
        path_name.join template_pack_name + '_with_fieldname_values.tex'
      end

      def pack_documentation_dir_path
        path_name.join 'doc'
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
