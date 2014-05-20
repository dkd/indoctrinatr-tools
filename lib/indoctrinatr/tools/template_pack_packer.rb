require 'indoctrinatr/tools/template_pack_helpers'
require 'zip'

module Indoctrinatr
  module Tools
    class TemplatePackPacker
      include TemplatePackHelpers

      attr_accessor :template_pack_name, :path_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
        @path_name = Pathname.new(Dir.pwd).join template_pack_name
      end

      def call
        check_for_folder
        remove_existing_zip
        zip_template_folder
        show_success
      end

      private

      def remove_existing_zip
        FileUtils.rm destination_zip_file, force: true
      end

      def zip_template_folder
        Zip::File.open(destination_zip_file, Zip::File::CREATE) do |zipfile|
          Dir[File.join(path_name, '**', '**')].each do |file|
            zipfile.add(internal_file_name(file), file)
          end
        end
      end

      def show_success
        puts "The template pack '#{template_pack_name}.zip' was created successfully."
      end

      def destination_zip_file
        Pathname.new(Dir.pwd).join "#{template_pack_name}.zip"
      end

      def internal_file_name file_name
        file_name.sub(path_name.to_s, '')[1..-1] # remove leading /
      end
    end
  end
end
