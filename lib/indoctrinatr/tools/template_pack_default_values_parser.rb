require 'indoctrinatr/tools/template_pack_helpers'
require 'indoctrinatr/tools/default_values'
require 'erubis'
require 'to_latex'

module Indoctrinatr
  module Tools
    class TemplatePackDefaultValuesParser
      include TemplatePackHelpers

      attr_accessor :template_pack_name, :configuration, :default_values, :tex_file_content, :parsed_tex_file_content

      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call
        check_for_folder
        read_config_file
        read_tex_file
        parse_tex_file
        write_tex_file
        show_success
      end

      private

      def read_config_file
        @configuration = YAML.load_file config_file_path
        attributes_as_hashes_in_array = @configuration.fetch 'fields', []
        attributes_as_hashes_in_array << { 'name' => 'template_asset_path', 'default_value' => assets_path }
        @default_values = DefaultValues.new attributes_as_hashes_in_array
      end

      def read_tex_file
        @tex_file_content = File.read tex_file_path
      end

      def parse_tex_file
        @parsed_tex_file_content = Erubis::Eruby.new(@tex_file_content).result(default_values.retrieve_binding)
      end

      def write_tex_file
        File.write tex_with_default_values_file_path, parsed_tex_file_content
      end

      def show_success
        puts "The template pack '#{template_pack_name}' has been successfully parsed with default values."
      end
    end
  end
end
