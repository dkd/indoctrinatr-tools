require 'redcloth'

module Indoctrinatr
  module Tools
    class DefaultValues
      def initialize attributes_as_hashes_in_array = []
        attributes_as_hashes_in_array.each do |attribute_hash|
          instance_variable_set("@#{attribute_hash['name']}", attribute_hash['default_value'])

          define_singleton_method "raw_#{attribute_hash['name']}".to_sym do
            instance_variable_get("@#{attribute_hash['name']}")
          end

          define_singleton_method attribute_hash['name'].to_sym do
            instance_variable_get("@#{attribute_hash['name']}").to_latex
          end
        end
      end

      def textile2latex textile
        RedCloth.new(textile).to_latex
      end

      def retrieve_binding
        binding
      end
    end
  end
end
