require 'indoctrinatr/tools/content_for_tex_files'

module Indoctrinatr
  module Tools
    class DefaultValues < ContentForTexFiles
      def output_file_name
        @_output_file_name
      end

      def default_file_name
        @_default_file_name
      end

      def _use_default_values # rubocop:disable Metrics/AbcSize
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
