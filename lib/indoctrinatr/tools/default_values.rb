require 'redcloth'

module Indoctrinatr
  module Tools
    class DefaultValues
      def initialize configuration # rubocop:disable Metrics/AbcSize
        @_configuration = configuration
        _build_from_configuration
      end

      def textile2latex textile
        RedCloth.new(textile).to_latex
      end

      def retrieve_binding
        binding
      end

      def customized_output_file_name
        @_customized_output_file_name ||= eval('"' + @_output_file_name + '"') # rubocop:disable Lint/Eval
      end

      def template_asset_path
        @_template_asset_path
      end

      def output_file_name
        @_output_file_name
      end

      def default_file_name
        @_default_file_name
      end

      def _build_from_configuration # rubocop:disable Metrics/AbcSize
        @_template_asset_path = @_configuration.template_asset_path
        @_output_file_name = @_configuration.output_file_name
        @_default_file_name = @_configuration.default_file_name

        @_configuration.attributes_as_hashes_in_array.each do |attribute_hash|
          instance_variable_set("@_#{attribute_hash['name']}", attribute_hash['default_value'])

          define_singleton_method "raw_#{attribute_hash['name']}".to_sym do
            instance_variable_get("@_#{attribute_hash['name']}")
          end

          define_singleton_method attribute_hash['name'].to_sym do
            instance_variable_get("@_#{attribute_hash['name']}").to_latex
          end
        end
      end
    end
  end
end
