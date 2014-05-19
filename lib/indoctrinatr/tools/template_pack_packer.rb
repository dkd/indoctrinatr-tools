require 'zip'

module Indoctrinatr
  module Tools
    class TemplatePackPacker
      attr_accessor :template_pack_name, :path_name, :destination_zip_file

      def initialize template_pack_name
        @template_pack_name = template_pack_name
        @path_name = Pathname.new(Dir.pwd).join template_pack_name
        @destination_zip_file = Pathname.new(Dir.pwd).join "#{template_pack_name}.zip"
      end

      def call
        check_for_folder
        remove_existing_zip
        zip_template_folder
      end

      private

      def check_for_folder
        unless Dir.exists? path_name
          raise "A folder with name '#{template_pack_name}' does not exist."
        end
      end

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

      def internal_file_name file_name
        file_name.sub(path_name.to_s, '')[1..-1] # remove leading /
      end
    end
  end
end
