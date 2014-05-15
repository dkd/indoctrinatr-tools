module Indoctrinatr
  module Tools
    class TemplatePackScaffold
      attr_reader :template_name, :path_name, :config_file_path

      def initialize template_name
        @template_name = template_name
        @path_name = Pathname.new(Dir.pwd).join template_name
      end

      def call
        create_folder
        create_configuration_file
        create_tex_file
      end

      private

      def create_folder
        if Dir.exists? path_name
          raise "A folder with name #{template_name} already exists."
        else
          Dir.mkdir path_name          
        end
      end

      def create_configuration_file
        File.open(config_file_path, 'w') do |config_file|
          config_file.write default_template_config_content
        end
      end

      def create_tex_file
      end

      def config_file_path
        path_name.join 'configuration.yaml'
      end

      def default_template_config_content
"template_name: '#{template_name}'
template_description: 'Describe your template here'
attributes:
  -
    name: first_attribute
    data_type: Text
    default_value: 'default value of first attribute'
  -
    name: second_attribute
    data_type: Text
    default_value: 'default value of second attribute'
"
      end
    end
  end
end
