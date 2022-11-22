require_relative '../template_pack_default_values_parser'

module Indoctrinatr
  module Tools
    module Commands
      class Parse < Dry::CLI::Command
        desc 'Parse XeTeX file with ERB and default values of Template Pack'

        argument :template_pack_name, desc: 'Name of template pack'

        def call(template_pack_name:, **)
          TemplatePackDefaultValuesParser.new.call(template_pack_name) do |result|
            result.success do
              puts "The template pack '#{template_pack_name}' has been successfully parsed with default values."
            end

            result.failure do |message|
              puts message
            end
          end
        end
      end
    end
  end
end
