module Indoctrinatr
  module Tools
    module Commands
      class Demo < Dry::CLI::Command
        desc 'Create, compile and pack a demo project.'

        def call(**)
          Indoctrinatr::Tools::Transactions::TemplatePackDemo.new.call('demo') do |result|
            result.success do |message|
              puts message
            end

            result.failure do |message|
              puts message
              exit 1
            end
          end
        end
      end
    end
  end
end
