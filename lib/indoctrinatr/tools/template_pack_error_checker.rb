require 'indoctrinatr/tools/template_pack_helpers'

module Indoctrinatr
  module Tools
    class TemplatePackErrorChecker
      include Dry::Transaction

      # class wide constants
      # needs to match indoctrinatr's TemplateField model
      VALID_PRESENTATIONS = %w[text textarea checkbox radiobutton dropdown date range file].freeze
      REQUIRES_AVAILABLE_OPTIONS = %w[dropdown checkbox radiobutton].freeze

      step :setup
      step :check_config_file_existence
      step :check_config_file_syntax
      step :check_attributes

      # TODO: check multiple variable name declaration (low-prio)

      private

      def setup(template_pack_name)
        path_name = Pathname.new(Dir.pwd).join template_pack_name
        config_file_path = path_name.join 'configuration.yaml'
        Success(
          {
            template_pack_name:,
            path_name:,
            config_file_path:
          }
        )
      rescue StandardError => e
        Failure(e.message)
      end

      def check_config_file_existence(config)
        return Failure('The file configuration.yaml does not exist in the template_pack directory') unless File.exist? config[:config_file_path]

        Success(config)
      rescue StandardError => e
        Failure(e.message)
      end

      # YAML syntax check
      def check_config_file_syntax(config)
        puts 'Checking YAML syntax...'
        YAML.parse_file config[:config_file_path]
        puts 'YAML syntax ok!'
        Success(config)
      rescue YAML::SyntaxError => e # no program abort when this exception is thrown
        puts 'YAML syntax error in configuration.yaml, see error for details:'
        Failure(e.message)
      rescue StandardError => e
        Failure(e.message)
      end

      def check_attributes(config)
        configuration = ConfigurationExtractor.new(config[:template_pack_name]).call
        puts 'Checking...'

        configuration.attributes_as_hashes_in_array.each_with_index do |attribute_hash, index|
          identifier = "Variable number #{index + 1}" # string for the user to localize variable with errors/warnings
          name_field = check_field_attribute attribute_hash, identifier, 'name'
          identifier = "Variable \"#{name_field}\"" if name_field != false

          check_presentation attribute_hash, identifier

          check_field_attribute attribute_hash, identifier, 'default_value'

          check_field_attribute attribute_hash, identifier, 'description'
          # idea: warning if no required attribute?
        end
        Success()
      rescue StandardError => e
        Failure(e.message)
      end

      # false if something wrong, otherwise returns the key value
      def check_field_attribute(attribute_hash, field_identifier, key)
        unless attribute_hash.key? key
          puts "The #{field_identifier} has no #{key} type set!"
          return false
        end
        if attribute_hash[key].nil? || attribute_hash[key].empty?
          puts "The #{field_identifier} has an empty #{key}!"
          false
        else
          attribute_hash[key]
        end
      end

      def check_presentation(attribute_hash, identifier)
        presentation = check_field_attribute attribute_hash, identifier, 'presentation'
        return false unless presentation

        # check if it is one of the options
        puts "Not an allowed presentation option set for #{identifier}" unless VALID_PRESENTATIONS.include? presentation
        check_available_options attribute_hash, identifier, presentation if REQUIRES_AVAILABLE_OPTIONS.include? presentation
        check_presentation_range attribute_hash, identifier, presentation if presentation == 'range'
      end

      def check_available_options(attribute_hash, identifier, presentation_type)
        unless attribute_hash.key? 'available_options'
          puts "The #{identifier} has no available_options (needed for #{presentation_type} presentation)"
          return false
        end
        available_options = attribute_hash['available_options']
        if available_options.nil?
          puts("available_options for #{identifier} is empty (needed for #{presentation_type} presentation)")
          false
        else
          puts("available_options for #{identifier} has only one option. That is useless.") if available_options.count(',') == 1
          true
        end
      end

      def check_presentation_range(attribute_hash, identifier, presentation)
        puts "The #{identifier} has no start_of_range field (needed for #{presentation} presentation)" unless attribute_hash.key? 'start_of_range'
        puts "The #{identifier} has no end_of_range field (needed for #{presentation} presentation)" unless attribute_hash.key? 'end_of_range'
        # TODO: check for content
      end
    end
  end
end
