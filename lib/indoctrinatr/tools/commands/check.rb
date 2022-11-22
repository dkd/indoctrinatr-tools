require_relative '../template_pack_error_checker'

module Indoctrinatr
  module Tools
    module Commands
      class Check < Dry::CLI::Command
        desc 'Display the suggested workflow'

        argument :template_pack_name, desc: 'Name of template pack'

        def call(template_pack_name:, **)
          TemplatePackErrorChecker.new.call(template_pack_name) do |result|
            result.success do
            end
            result.failure do |message|
              puts message
              return
            end
          end
        end
      end
    end
  end
end
