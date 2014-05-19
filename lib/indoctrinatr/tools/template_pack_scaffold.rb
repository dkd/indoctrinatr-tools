module Indoctrinatr
  module Tools
    class TemplatePackScaffold
      attr_reader :template_pack_name, :path_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
        @path_name = Pathname.new(Dir.pwd).join template_pack_name
      end

      def call
        create_folder
        copy_configuration_file
        copy_tex_file
        show_success
      end

      private

      def create_folder
        if Dir.exists? path_name
          raise "A folder with name '#{template_pack_name}' already exists."
        else
          Dir.mkdir path_name          
        end
      end
 
      def copy_configuration_file
        source_config_file = Pathname.new(File.expand_path(File.dirname(__FILE__))).join('..', 'templates', ''configuration.yaml'')
        
        FileUtils.copy_file source_config_file, path_name
        # File.open(config_file_path, 'w') do |config_file|
        #   config_file.write default_configuration_file_content
        # end
      end

      def copy_tex_file
        # File.open(tex_file_path, 'w') do |tex_file|
        #   tex_file.write default_tex_file_content
        # end
      end

      def show_success
        puts "A template pack in folder '#{template_pack_name}' was created. Happy templating…"
      end

      def config_file_path
        path_name.join 'configuration.yaml'
      end

      def tex_file_path
        path_name.join 'template.tex'
      end
    end
  end
end
