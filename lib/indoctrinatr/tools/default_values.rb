module Indoctrinatr
  module Tools
    class DefaultValues
      def initialize attributes_as_hashes_in_array
        attributes_as_hashes_in_array.each do |attribute_hash|
          (class << self; self; end).send(:define_method, attribute_hash.name.to_sym, -> { instance_variable_get("@#{attribute_hash.name}").to_s.to_latex })
          instance_variable_set("@#{attribute_hash.name}", attribute_hash.default_value)
        end
      end

      def get_binding
        binding
      end
    end
  end
end
