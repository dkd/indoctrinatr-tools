require 'indoctrinatr/tools/content_for_tex_files'

module Indoctrinatr
  module Tools
    # This class defines the content for a document that has the field names as content.
    class FieldNameValues < ContentForTexFiles
      # TODO: extensive list of possibilities
      PICTURE_FILE_ENDINGS = %w(.png .jpeg .jpg .bmp .gif .pdf).freeze
      def _field_names_as_values # rubocop:disable Metrics/AbcSize
        @_configuration.attributes_as_hashes_in_array.each do |attribute_hash|
          # Usage of \textless to avoid issues with the < > characters.
          # Usage of * character because it does not produce any issues when it's used in arguments of LaTeX commands.
          # Initially the intention was to use texttt, but that had this problem.
          instance_variable_set("@_#{attribute_hash['name']}",
                                "\\textless***#{attribute_hash['name'].to_latex}***\\textgreater")

          define_singleton_method "raw_#{attribute_hash['name']}".to_sym do
            "raw\\_#{instance_variable_get("@_#{attribute_hash['name']}")}"
          end

          define_singleton_method attribute_hash['name'].to_sym do
            # No usage of to_latex because we escaped variable name already and want no escaping for the other stuff
            instance_variable_get("@_#{attribute_hash['name']}")
          end
        end
        # This overwrites the instance attributes and methods again
        overwrite_picture_file_names_output @_configuration.attributes_as_hashes_in_array
      end

      # The LaTeX compilation would fail if the \includegraphics tries to include a file that does not exist.
      # Because of that it makes sense to simply use the default values again if user sets file names.
      def overwrite_picture_file_names_output attributes_as_hashes # rubocop:disable Metrics/AbcSize
        attributes_as_hashes.each do |attribute_hash|
          # search for typical picture file endings
          next unless detect_picture_file_names attribute_hash['default_value']
          instance_variable_set("@_#{attribute_hash['name']}", attribute_hash['default_value'])

          define_singleton_method "raw_#{attribute_hash['name']}".to_sym do
            "raw\\_#{instance_variable_get("@_#{attribute_hash['name']}")}"
          end

          define_singleton_method attribute_hash['name'].to_sym do
            instance_variable_get("@_#{attribute_hash['name']}").to_latex
          end
        end
      end

      # Indoctrinatr has no picture data type. This means that the only way to check for pictures is to check for
      # file endings. If an user has obscure file type the possibility list would have to get updated.
      def detect_picture_file_names string_to_check
        PICTURE_FILE_ENDINGS.any? do |picture_file_ending|
          string_to_check.downcase.include? picture_file_ending # http://stackoverflow.com/a/3686568
        end
      end
    end
  end
end
