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
        create_asset_folder
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

      def create_asset_folder
        Dir.mkdir path_name.join('assets')
      end
 
      def copy_configuration_file
        source_config_file = Pathname.new(File.expand_path(File.dirname(__FILE__))).join('..', 'templates', 'configuration.yaml')
        destination_config_file = path_name.join('configuration.yaml')
        FileUtils.copy_file source_config_file, destination_config_file
      end

      def copy_tex_file
        source_tex_file = Pathname.new(File.expand_path(File.dirname(__FILE__))).join('..', 'templates', 'template.tex')
        destination_tex_file = path_name.join('template.tex')
        FileUtils.copy_file source_tex_file, destination_tex_file
      end

      def show_success
        puts "A template pack scaffold was created in folder '#{template_pack_name}'. Happy templating…"
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
