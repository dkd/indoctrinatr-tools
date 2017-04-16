require 'redcloth'

module Indoctrinatr
  module Tools
    class ContentForTexFiles
      # a class that DefaultValues, TemplateDocumentationContent, and field_names_as_variables should inherit from
      # or to be precise: When we want use variables in an indoctrinatr tex.erb file, we should use this class
      def initialize configuration
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
        @_customized_output_file_name ||= eval('"' + @_output_file_name + '"') # rubocop:disable Security/Eval
      end

      def template_asset_path
        @_template_asset_path
      end

      def _build_from_configuration
        @_template_asset_path = @_configuration.template_asset_path
        @_output_file_name = @_configuration.output_file_name # does this fit here?
        @_default_file_name = @_configuration.default_file_name # does this fit here?
      end
    end
  end
end
