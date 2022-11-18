require 'indoctrinatr/tools/template_pack_helpers'
require 'fileutils'
require 'dry/transaction'

module Indoctrinatr
  module Tools
    class TemplatePackScaffold
      include Dry::Transaction

      step :setup
      step :validate_setup
      step :create_folder
      step :create_asset_folder
      step :copy_configuration_file
      step :copy_tex_file

      private

      def setup(template_pack_name)
        path_name = Pathname.new(Dir.pwd).join(template_pack_name)
        Success(
          {
            template_pack_name:,
            path_name:,
            source_config_file_path: Pathname.new(File.expand_path(__dir__)).join('..', 'templates', 'configuration.yaml'),
            source_tex_file_path: Pathname.new(File.expand_path(__dir__)).join('..', 'templates', 'template.tex.erb'),
            assets_path: path_name.join('assets'),
            config_file_path: path_name.join('configuration.yaml'),
            tex_file_path: path_name.join("#{template_pack_name}.tex.erb")
          }
        )
      end

      def validate_setup(config)
        return Failure('Please specify a template pack name.') if config[:template_pack_name].nil? || config[:template_pack_name].empty?
        return Failure("A folder with name '#{config[:template_pack_name]}' already exists.") if Dir.exist? config[:path_name]

        Success(config)
      end

      def create_folder(config)
        FileUtils.mkdir_p config[:path_name]
        Success(config)
      rescue Errno::EROFS
        Failure('Could not write to target directory!')
      rescue StandardError => e
        Failure(e.message)
      end

      def create_asset_folder(config)
        FileUtils.mkdir_p config[:assets_path]
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def copy_configuration_file(config)
        FileUtils.copy_file config[:source_config_file_path], config[:config_file_path]
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def copy_tex_file(config)
        FileUtils.copy_file config[:source_tex_file_path], config[:tex_file_path]
        Success()
      rescue StandardError => e
        Failure(e.message)
      end
    end
  end
end
