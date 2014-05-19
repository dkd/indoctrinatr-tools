require 'zip'

module Indoctrinatr
  module Tools
    class TemplatePackPacker
      attr_accessor :template_pack_name, :path_name

      def initialize template_pack_name
        @template_pack_name = template_pack_name
        @path_name = Pathname.new(Dir.pwd).join template_pack_name
      end

      def call
        zip_template_folder
      end

      private

      def zip_template_folder
        destination_zip_file = path_name.join '..', "#{template_pack_name}.zip"
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
