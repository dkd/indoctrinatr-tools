require_relative '../template_pack_packer'

module Indoctrinatr
  module Tools
    module Commands
      class Pack < Dry::CLI::Command
        desc 'Create a Template Pack from a given source folder'

        argument :template_pack_name, desc: 'Name of template pack'

        def call(template_pack_name:, **)
          TemplatePackPacker.new.call(template_pack_name) do |result|
            result.success do
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