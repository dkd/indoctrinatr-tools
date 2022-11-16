module Indoctrinatr
  module Tools
    class TemplateDocumentationSourceFile
      attr_reader :name, :content, :language

      def initialize(filename)
        @name = filename
        @content = File.read filename
        @language = set_programming_language
      end

      private

      def set_programming_language
        case File.extname(@name)
        when '.tex', '.sty', '.erb'
          'TeX'
        when '.rb'
          'Ruby'
        else # probably YAML
          'unspecified'
        end
      end
    end
  end
end
