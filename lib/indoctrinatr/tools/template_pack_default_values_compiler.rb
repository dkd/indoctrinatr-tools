module Indoctrinatr
  module Tools
    class TemplatePackDefaultValuesCompiler
      include TemplatePackHelpers

      attr_accessor :template_pack_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call
        check_for_folder
        compile_tex_file
      end

      private

      def compile_tex_file
        args = ['-shell-escape', '-interaction', 'batchmode', tex_with_default_values_file_path.to_s]
        2.times do
          system 'xelatex', *args
        end
      end
    end
  end
end
