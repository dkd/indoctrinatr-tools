module Indoctrinatr
  module Tools
    module TemplatePackHelpers
      def path_name
        Pathname.new(Dir.pwd).join template_pack_name
      end

      def check_for_folder
        raise 'Please specify a template pack name.' if template_pack_name.empty?
        raise "A folder with name '#{template_pack_name}' does not exist." unless Dir.exists? path_name
      end

      def config_file_path
        path_name.join 'configuration.yaml'
      end

      def tex_file_path
        path_name.join template_pack_name, '.tex.erb'
      end
    end
  end
end
