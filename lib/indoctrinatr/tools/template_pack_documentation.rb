require 'indoctrinatr/tools/template_documentation_content'
require 'indoctrinatr/tools/template_pack_helpers'
require 'indoctrinatr/tools/template_documentation_helpers'
require 'indoctrinatr/tools/configuration_extractor'
require 'indoctrinatr/tools/pdf_generator'
require 'erubis'
require 'to_latex'
require 'fileutils'

module Indoctrinatr
  module Tools
    class TemplatePackDocumentation
      include PdfGenerator
      include Dry::Transaction

      step :setup
      step :fill_documentation_content
      step :read_content_tex_file
      step :read_main_tex_file
      step :parse_content_tex_file
      step :parse_main_tex_file
      step :create_temp_compile_dir
      step :compile_setup
      step :write_content_tex_file
      step :write_main_tex_file
      step :copy_source_files
      step :compile_documentation_to_pdf
      step :copy_doc_file_to_template_pack
      step :handle_aux_files
      step :show_success

      private

      def setup(template_pack_name:, keep_aux_files:)
        documentation_files_path = Pathname.new(File.expand_path(__dir__)).join('..', 'templates', 'documentation')
        content_tex_file_path = documentation_files_path.join 'indoctrinatr-technical-documentation-content.tex.erb'
        source_main_tex_file_path = documentation_files_path.join 'indoctrinatr-technical-documentation.tex.erb'
        path_name = Pathname.new(Dir.pwd).join template_pack_name
        pack_documentation_dir_path = path_name.join 'doc'
        pack_technical_documentation_file_path = pack_documentation_dir_path.join "#{template_pack_name}_technical_documentation.pdf"
        Success(
          {
            content_tex_file_path:,
            template_pack_name:,
            documentation_files_path:,
            keep_aux_files:,
            source_main_tex_file_path:,
            pack_documentation_dir_path:,
            pack_technical_documentation_file_path:,
            path_name:
          }
        )
      end

      def fill_documentation_content(config)
        configuration = ConfigurationExtractor.new(config[:template_pack_name]).call
        begin
          documentation_content = TemplateDocumentationContent.new(config[:template_pack_name], configuration)
          config[:documentation_content] = documentation_content
        rescue IOError => e
          Failure(e.message)
        end
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def read_content_tex_file(config)
        content_tex_file_content = File.read(config[:content_tex_file_path], encoding: 'Utf-8')
        config[:content_tex_file_content] = content_tex_file_content
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def read_main_tex_file(config)
        main_tex_file_content = File.read(config[:source_main_tex_file_path], encoding: 'Utf-8')
        config[:main_tex_file_content] = main_tex_file_content
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def parse_content_tex_file(config)
        parsed_content_tex_file_content = Erubis::Eruby.new(config[:content_tex_file_content]).result(config[:documentation_content].retrieve_binding)
        config[:parsed_content_tex_file_content] = parsed_content_tex_file_content
        # TODO: more useful error messages for user on errors
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def parse_main_tex_file(config)
        parsed_main_tex_file_content = Erubis::Eruby.new(config[:main_tex_file_content]).result(config[:documentation_content].retrieve_binding)
        config[:parsed_main_tex_file_content] = parsed_main_tex_file_content
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def create_temp_compile_dir(config)
        documentation_compile_dir_path_name = Pathname.new Dir.mktmpdir 'indoctrinatr_tools_tmp'
        config[:documentation_compile_dir_path_name] = documentation_compile_dir_path_name
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def compile_setup(config)
        content_tex_file_destination_path = config[:documentation_compile_dir_path_name].join 'indoctrinatr-technical-documentation-content.tex'
        config[:content_tex_file_destination_path] = content_tex_file_destination_path

        main_tex_file_destination_path = config[:documentation_compile_dir_path_name].join 'indoctrinatr-technical-documentation.tex'
        config[:main_tex_file_destination_path] = main_tex_file_destination_path

        source_latex_package_file_path = config[:documentation_files_path].join 'indoctrinatr-technical-documentation.sty'
        config[:source_latex_package_file_path] = source_latex_package_file_path

        latex_package_destination_path = config[:documentation_compile_dir_path_name].join 'indoctrinatr-technical-documentation.sty'
        config[:latex_package_destination_path] = latex_package_destination_path

        source_letterpaper_file_path = config[:documentation_files_path].join 'indoctrinatr_letterpaper.pdf'
        config[:source_letterpaper_file_path] = source_letterpaper_file_path

        letterpaper_file_destination_path = config[:documentation_compile_dir_path_name].join 'indoctrinatr_letterpaper.pdf'
        config[:letterpaper_file_destination_path] = letterpaper_file_destination_path

        source_image_tools_package_file_path = config[:documentation_files_path].join 'dkd-image-tools.sty'
        config[:source_image_tools_package_file_path] = source_image_tools_package_file_path

        image_tools_package_destination_path = config[:documentation_compile_dir_path_name].join 'dkd-image-tools.sty'
        config[:image_tools_package_destination_path] = image_tools_package_destination_path

        latex_log_file = config[:documentation_compile_dir_path_name].join 'indoctrinatr-technical-documentation.log'
        config[:latex_log_file] = latex_log_file

        latex_log_file_destination = config[:path_name].join "#{config[:template_pack_name]}documentation_latex_failure.log"
        config[:latex_log_file_destination] = latex_log_file_destination

        documentation_file_path = config[:documentation_compile_dir_path_name].join 'indoctrinatr-technical-documentation.pdf'
        config[:documentation_file_path] = documentation_file_path

        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def write_content_tex_file(config)
        File.write config[:content_tex_file_destination_path], config[:parsed_content_tex_file_content]
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def write_main_tex_file(config)
        File.write config[:main_tex_file_destination_path], config[:parsed_main_tex_file_content]
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def copy_source_files(config)
        FileUtils.copy_file config[:source_latex_package_file_path], config[:latex_package_destination_path]
        FileUtils.copy_file config[:source_letterpaper_file_path], config[:letterpaper_file_destination_path]
        FileUtils.copy_file config[:source_image_tools_package_file_path], config[:image_tools_package_destination_path]
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def compile_documentation_to_pdf(config)
        begin
          make_pdf config[:main_tex_file_destination_path], config[:documentation_compile_dir_path_name], cleanup: !config[:keep_aux_files]
        rescue StandardError => e
          Failure(e.message)
        else
          if config[:keep_aux_files]
            copy_helper_files_to_template_pack(config)
            show_temp_directory(config)
          end
          handle_latex_error(config)
          Failure()
        end
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def copy_helper_files_to_template_pack(config)
        helper_files_to_copy = [config[:latex_log_file], config[:content_tex_file_destination_path], config[:main_tex_file_destination_path]].freeze
        FileUtils.mkdir_p(config[:pack_documentation_dir_path])
        FileUtils.copy helper_files_to_copy, config[:pack_documentation_dir_path]
        puts 'TeX files and log file have been copied to doc subdirectory of your template_pack'
      rescue StandardError => e
        Failure(e.message)
      end

      def copy_doc_file_to_template_pack(config)
        # All the documentation shall go into template_pack/doc
        FileUtils.mkdir_p(config[:pack_documentation_dir_path])
        FileUtils.copy_file config[:documentation_file_path], config[:pack_technical_documentation_file_path]
        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      def handle_aux_files(config)
        if config[:keep_aux_files]
          copy_helper_files_to_template_pack(config)
          show_temp_directory(config)
        else
          delete_temp_dir(config)
        end
        Success()
      rescue StandardError => e
        Failure(e.message)
      end

      def show_temp_directory(config)
        puts "Look into the directory #{config[:documentation_compile_dir_path_name]} to see all files related to the technical documentation compilation"
      end

      def delete_temp_dir(config)
        FileUtils.remove_entry_secure config[:documentation_compile_dir_path_name]
      end

      def handle_latex_error(config)
        puts "possible LaTeX compilation failure! see #{config[:latex_log_file_destination]} for details. " # idea: process $CHILD_STATUS
        FileUtils.copy_file config[:latex_log_file], config[:latex_log_file_destination]
      end

      def show_success
        puts "A documentation for '#{template_pack_name}' has been successfully generated."
        Success()
      end
    end
  end
end
