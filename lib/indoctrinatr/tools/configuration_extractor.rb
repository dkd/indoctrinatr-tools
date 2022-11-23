require 'yaml'

module Indoctrinatr
  module Tools
    class ConfigurationExtractor
      include TemplatePackHelpers

      attr_reader :template_pack_name

      def initialize(template_pack_name)
        @template_pack_name = template_pack_name
      end

      def call
        config_file = YAML.load_file((Pathname.new(Dir.pwd).join template_pack_name).join('configuration.yaml'))
        configuration = TemplatePackConfiguration.new
        configuration.template_asset_path = (path_name(template_pack_name).join 'assets').to_s
        configuration.default_file_name = "#{template_pack_name}_with_default_values.pdf"
        configuration.output_file_name = config_file.fetch('output_file_name', "#{template_pack_name}_with_default_values.pdf")
        configuration.template_name = config_file.fetch 'template_name'
        configuration.textual_description = config_file.fetch('textual_description'), ''
        configuration.attributes_as_hashes_in_array = config_file.fetch 'fields', []
        configuration
      end
    end
  end
end
