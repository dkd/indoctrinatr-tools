require 'indoctrinatr/tools/content_for_tex_files'

module Indoctrinatr
  module Tools
    class FieldNameValues < ContentForTexFiles
      def _field_names_as_values # rubocop:disable Metrics/AbcSize
        @_configuration.attributes_as_hashes_in_array.each do |attribute_hash|
          # work around to_latex not escaping the < and > chars
          instance_variable_set("@_#{attribute_hash['name']}", "\\texttt{<\\%= #{attribute_hash['name'].to_latex} -\\%>}")
          # TODO: differentiate between -%> and %> ?

          define_singleton_method "raw_#{attribute_hash['name']}".to_sym do
            "\\texttt{<\\%= raw\\_#{attribute_hash['name'].to_latex} -\\%>}"
          end

          define_singleton_method attribute_hash['name'].to_sym do
            instance_variable_get("@_#{attribute_hash['name']}") # we escaped variable name already and don't want no escape for the other stuff
          end
        end
      end
    end
  end
end
