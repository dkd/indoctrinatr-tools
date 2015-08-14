module Indoctrinatr
  module Tools
    class TemplateDocumentationSourceFile
      attr_reader :name, :content, :language

      def initialize filename
        @name = filename
        @content = File.read filename
        @language = set_programming_language
      end

      private

      def set_programming_language
        case File.extname(@name)
        when '.tex'
          language = 'TeX'
        when '.sty'
          language = 'TeX'
        when '.erb' # .erb files are just supposed to be tex.erb files. TODO: more correct
          language = 'TeX'
        when '.rb'
          language = 'Ruby'
        else # probably YAML
          language = 'unspecified'
        end
        language
      end
    end
  end
end
