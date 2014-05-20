require 'indoctrinatr/tools/template_pack_helpers'

module Indoctrinatr
  module Tools
    class TemplatePackCleaner
      include TemplatePackHelpers

      attr_accessor :template_pack_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call
        cleanup_log_files
        cleanup_aux_files
      end

      private

      def cleanup_log_files
        Dir[File.join(path_name, '**', '*.log',)].each do |file|
          FileUtils.rm file, force: true
        end
      end

      def cleanup_aux_files
        Dir[File.join(path_name, '**', '*.aux')].each do |file|
          FileUtils.rm file, force: true
        end
      end
    end
  end
end
