require 'indoctrinatr/tools/template_pack_helpers'
require 'fileutils'

module Indoctrinatr
  module Tools
    class TemplatePackScaffold
      include TemplatePackHelpers

      attr_accessor :template_pack_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
      end

      def call
        create_folder
        create_asset_folder
        copy_configuration_file
        copy_tex_file
        show_success
      end

      private

      def create_folder
        fail 'Please specify a template pack name.' if template_pack_name.nil? || template_pack_name.empty? # rubocop:disable Style/SignalException
        fail "A folder with name '#{template_pack_name}' already exists." if Dir.exist? path_name # rubocop:disable Style/SignalException

        Dir.mkdir path_name
      end

      def create_asset_folder
        Dir.mkdir path_name.join('assets')
      end

      def copy_configuration_file
        FileUtils.copy_file source_config_file_path, config_file_path
      end

      def copy_tex_file
        FileUtils.copy_file source_tex_file_path, tex_file_path
      end

      def show_success
        puts "A template pack scaffold was created in folder '#{template_pack_name}'. Happy templating…"
      end

      def source_config_file_path
        Pathname.new(File.expand_path(__dir__)).join('..', 'templates', 'configuration.yaml')
      end

      def source_tex_file_path
        Pathname.new(File.expand_path(__dir__)).join('..', 'templates', 'template.tex.erb')
      end
    end
  end
end
