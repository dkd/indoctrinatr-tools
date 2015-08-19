require 'indoctrinatr/tools/template_pack_helpers'

module Indoctrinatr
  module Tools
    class TemplatePackErrorChecker
      include TemplatePackHelpers

      attr_accessor :template_pack_name, :config_file
      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call
        puts 'check stuff'
        check_config_file_existence
        check_config_file_syntax
      end

      def check_config_file_existence
        return true if File.exist? config_file_path
        puts 'could not find the file configuration.yaml. Did you forget to add it?'
      end

      def check_config_file_syntax # YAML syntax check
        puts 'checking YAML syntax...'
        begin
          YAML.parse_file config_file_path
        rescue YAML::SyntaxError => exception # TODO: file load error?
          puts 'possible syntax error in YAML configuration. See error for details:'
          raise exception.message
        end
        puts 'no YAML syntax errors.'
      end

      def check_attributes
        puts 'checking your attributes...'
      end
    end
  end
end
