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
        language =  case File.extname(@name)
                    when '.tex'
                      'TeX'
                    when '.sty'
                      'TeX'
                    when '.erb' # .erb files are just supposed to be tex.erb files. TODO: more correct
                      'TeX'
                    when '.rb'
                      'Ruby'
                    else # probably YAML
                      'unspecified'
                    end
        language
      end
    end
  end
end
