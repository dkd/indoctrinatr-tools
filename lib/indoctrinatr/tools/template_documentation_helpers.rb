require 'tmpdir'

module Indoctrinatr
  module Tools
    module TemplateDocumentationHelpers
      attr_accessor :documentation_compile_dir_path_name

      def make_documentation_compile_dir_path_name
        @documentation_compile_dir_path_name = Pathname.new Dir.mktmpdir 'indoctrinatr_tools_tmp'
      end

      def content_tex_file_path
        documentation_files_path.join 'indoctrinatr-technical-documentation-content.tex.erb'
      end

      def source_latex_package_file_path
        documentation_files_path.join 'indoctrinatr-technical-documentation.sty'
      end

      def source_letterpaper_file_path
        documentation_files_path.join 'indoctrinatr_letterpaper.pdf'
      end

      def source_main_tex_file_path
        documentation_files_path.join 'indoctrinatr-technical-documentation.tex.erb'
      end

      def latex_package_destination_path
        documentation_compile_dir_path_name.join 'indoctrinatr-technical-documentation.sty'
      end

      def letterpaper_file_destination_path
        documentation_compile_dir_path_name.join 'indoctrinatr_letterpaper.pdf'
      end

      def content_tex_file_destination_path
        documentation_compile_dir_path_name.join 'indoctrinatr-technical-documentation-content.tex'
      end

      def main_tex_file_destination_path
        documentation_compile_dir_path_name.join 'indoctrinatr-technical-documentation.tex'
      end

      def documentation_file_path
        documentation_compile_dir_path_name.join 'indoctrinatr-technical-documentation.pdf'
      end

      private

      def documentation_files_path
        Pathname.new(File.expand_path(File.dirname(__FILE__))).join('..', 'templates', 'documentation')
      end
    end
  end
end
