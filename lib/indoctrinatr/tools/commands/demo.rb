require_relative '../template_pack_demo'

module Indoctrinatr
  module Tools
    module Commands
      class Demo < Dry::CLI::Command
        desc 'Create, compile and pack a demo project'

        def call(**)
          TemplatePackDemo.new('demo').call
        end
      end
    end
  end
end
