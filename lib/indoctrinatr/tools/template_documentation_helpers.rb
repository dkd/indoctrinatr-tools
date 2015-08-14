module Indoctrinatr
  module Tools
    module TemplateDocumentationHelpers
      def path_name # TODO: unique naming
        Pathname.new(Dir.pwd)
      end

      def content_tex_file_path
        Pathname.new(File.expand_path(File.dirname(__FILE__))).join('..', 'templates', 'documentation', 'indoctrinatr-technical-documentation-content.tex.erb')
      end

      def source_latex_package_file_path
        Pathname.new(File.expand_path(File.dirname(__FILE__))).join('..', 'templates', 'documentation', 'indoctrinatr-technical-documentation.sty')
      end

      def source_letterpaper_file_path
        Pathname.new(File.expand_path(File.dirname(__FILE__))).join('..', 'templates', 'documentation', 'indoctrinatr_letterpaper.pdf')
      end

      def source_main_tex_file_path
        Pathname.new(File.expand_path(File.dirname(__FILE__))).join('..', 'templates', 'documentation', 'indoctrinatr-technical-documentation.tex.erb')
      end

      def latex_package_destination_path
        path_name.join 'indoctrinatr-technical-documentation.sty'
      end

      def letterpaper_file_destination_path
        path_name.join 'indoctrinatr_letterpaper.pdf'
      end

      def documentation_file_path
        path_name.join 'indoctrinatr-technical-documentation.tex'
      end
    end
  end
end
