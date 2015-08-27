require 'indoctrinatr/tools/template_pack_configuration'

module Indoctrinatr
  module Tools
    class ConfigurationExtractor
      include TemplatePackHelpers

      attr_reader :template_pack_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call # rubocop:disable Metrics/AbcSize
        config_file = YAML.load_file config_file_path
        configuration = TemplatePackConfiguration.new
        configuration.template_asset_path = assets_path.to_s
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
