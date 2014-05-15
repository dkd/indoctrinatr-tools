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
        create_configuration_file
        create_tex_file
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

      def create_configuration_file
        File.open(config_file_path, 'w') do |config_file|
          config_file.write default_configuration_file_content
        end
      end

      def create_tex_file
        File.open(tex_file_path, 'w') do |tex_file|
          tex_file.write default_tex_file_content
        end
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

      def default_configuration_file_content
"template_name: '#{template_pack_name}'
template_description: 'Describe your template here'
attributes:
  -
    name: first_attribute
    data_type: Text
    default_value: 'default value of first attribute'
  -
    name: second_attribute
    data_type: Text
    default_value: 'default value of second attribute'\n"
      end

      def default_tex_file_content
        "\n"
      end
    end
  end
end
