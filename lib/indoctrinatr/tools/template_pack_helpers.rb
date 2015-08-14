module Indoctrinatr
  module Tools
    module TemplatePackHelpers
      def path_name
        Pathname.new(Dir.pwd).join template_pack_name
      end

      def assets_path
        path_name.join 'assets'
      end

      def check_for_folder
        fail 'Please specify a template pack name.' if template_pack_name.empty?
        fail "A folder with name '#{template_pack_name}' does not exist." unless Dir.exist? path_name
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

      def pack_technical_documentation_file_path
        path_name.join template_pack_name + '_technical_documentation.pdf'
      end

      def latex_log_file_destination
        path_name.join template_pack_name + 'documentation_laTeX_failure.log'
      end
    end
  end
end
