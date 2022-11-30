require 'dry/transaction'
require 'zip'
require 'fileutils'

module Indoctrinatr
  module Tools
    module Transactions
      class TemplatePackPacker
        include Dry::Transaction

        step :setup
        step :validate_setup
        step :remove_existing_zip
        step :zip_template_folder
        step :show_success

        private

        def setup(template_pack_name)
          Success(
            {
              template_pack_name:,
              path_name: Pathname.new(Dir.pwd).join(template_pack_name)
            }
          )
        rescue StandardError => e
          Failure(e.message)
        end

        def validate_setup(config)
          return Failure('Please specify a template pack name.') if config[:template_pack_name].nil? || config[:template_pack_name].empty?
          return Failure("A folder with name '#{config[:template_pack_name]}' does not exist.") unless Dir.exist? config[:path_name]

          Success(config)
        rescue StandardError => e
          Failure(e.message)
        end

        def remove_existing_zip(config)
          ::FileUtils.rm destination_zip_file(config[:template_pack_name]), force: true
          Success(config)
        rescue StandardError => e
          Failure(e.message)
        end

        def zip_template_folder(config)
          Zip::File.open(destination_zip_file(config[:template_pack_name]), Zip::File::CREATE) do |zipfile|
            Dir[File.join(config[:path_name], '**', '**')].each do |file|
              zipfile.add(internal_file_name(file, config[:template_pack_name], config[:path_name]), file)
            end
          end
          Success(config)
        rescue StandardError => e
          Failure(e.message)
        end

        def show_success(config)
          Success("The template pack '#{config[:template_pack_name]}.zip' was created successfully.")
        rescue StandardError => e
          Failure(e.message)
        end

        def destination_zip_file(template_pack_name)
          Pathname.new(Dir.pwd).join "#{template_pack_name}.zip"
        end

        def internal_file_name(file_name, template_pack_name, path_name)
          "#{template_pack_name}/#{file_name.sub(path_name.to_s, '')[1..]}" # remove leading /
        end
      end
    end
  end
end
