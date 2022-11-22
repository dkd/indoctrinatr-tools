require 'erubis'
require 'to_latex'

module Indoctrinatr
  module Tools
    class TemplatePackDefaultValuesParser
      include Dry::Transaction

      step :setup
      step :check_setup
      step :read_config_file
      step :read_tex_file
      step :parse_tex_file
      step :write_tex_file

      private

      def setup(template_pack_name)
        path_name = Pathname.new(Dir.pwd).join template_pack_name
        pack_documentation_dir_path = path_name.join 'doc'
        pack_documentation_examples_dir_path = pack_documentation_dir_path.join('examples')
        tex_with_default_values_file_path = pack_documentation_examples_dir_path.join("#{template_pack_name}_with_default_values.tex")
        Success(
          {
            template_pack_name:,
            path_name:,
            pack_documentation_dir_path:,
            pack_documentation_examples_dir_path:,
            tex_with_default_values_file_path:
          }
        )
      end

      def check_setup(config)
        return Failure('Please specify a template pack name.') if config[:template_pack_name].empty?
        return Failure("A folder with name '#{config[:template_pack_name]}' does not exist.") unless Dir.exist? config[:path_name] # rub

        Success(config)
      end

      def read_config_file(config)
        configuration = ConfigurationExtractor.new(config[:template_pack_name]).call
        default_values = DefaultValues.new configuration
        default_values._use_default_values
        config[:default_values] = default_values
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def read_tex_file(config)
        tex_file_path = config[:path_name].join("#{config[:template_pack_name]}.tex.erb")
        config[:tex_file_content] = File.read tex_file_path
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def parse_tex_file(config)
        config[:parsed_tex_file_content] = Erubis::Eruby.new(config[:tex_file_content]).result(config[:default_values].retrieve_binding)
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def write_tex_file(config)
        # Create directory to avoid file creation errors
        FileUtils.mkdir_p(config[:pack_documentation_dir_path])
        FileUtils.mkdir_p(config[:pack_documentation_examples_dir_path])
        File.write config[:tex_with_default_values_file_path], config[:parsed_tex_file_content]
        Success()
      rescue StandardError => e
        Failure(e.message)
      end
    end
  end
end
