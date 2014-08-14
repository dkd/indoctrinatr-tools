module Indoctrinatr
  module Tools
    module TemplatePackHelpers
      def path_name
        Pathname.new(Dir.pwd).join template_pack_name
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
    end
  end
end
