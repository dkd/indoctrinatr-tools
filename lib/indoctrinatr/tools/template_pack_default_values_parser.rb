require 'indoctrinatr/tools/default_values'

module Indoctrinatr
  module Tools
    class TemplatePackDefaultValuesParser
      attr_accessor :template_pack_name, :path_name, :configuration, :default_values, :tex_file_content, :parsed_tex_file_content

      def initialize template_pack_name
        @template_pack_name = template_pack_name
        @path_name = Pathname.new(Dir.pwd).join template_pack_name
      end

      def call
        read_config_file
        read_tex_file
        parse_tex_file
        write_tex_file
      end

      private

      def read_config_file
        config_file_content = File.read path_name.join 'configuration.yaml'
        @configuration = YAML.load config_file_content
        attributes_as_hashes_in_array = @configuration.fetch "attributes", []
        @default_values = DefaultValues.new attributes_as_hashes_in_array
      end

      def read_tex_file
        @tex_file_content = File.read path_name.join 'template.tex'
      end

      def parse_tex_file
        @parsed_tex_file_content = Erubis::Eruby.new(@tex_file_content).result(default_values.get_binding)
      end

      def write_tex_file
        File.write(path_name.join('parsed_template.tex'), parsed_tex_file_content)
      end
    end
  end
end
