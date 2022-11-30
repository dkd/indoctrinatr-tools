module Indoctrinatr
  module Tools
    module Commands
      class Workflow < Dry::CLI::Command
        desc 'Display the suggested workflow.'

        def call(**)
          puts <<~HEREDOC
            The workflow for a project (e.g. demo) typically looks like this:

            1. Run in shell: indoctrinatr new demo
               Creates a new Indoctrinatr Template Pack in the folder demo

            2. Edit demo.tex.erb and configuration.yaml according to needs

            3. Run in shell: indoctrinatr parse demo
               Parses tex file demo_with_default_values.tex with ERB and default values from configuration.yaml

            4. Run in shell: indoctrinatr pdf demo
               Compiles PDF from demo_with_default_values.tex

            5. Run in shell: indoctrinatr pdf_with_field_names demo
               Compiles PDF from demo_with_fieldname_values.tex

            6. Run in shell: indoctrinatr check demo
               Analyzes your Template Pack for potential errors

            7. Run in shell: indoctrinatr doc demo
               Creates a technical documentation for the Template Pack

            8. Run in shell: indoctrinatr pack demo
               Creates demo.zip with all required file for upload to Indoctrinatr server
          HEREDOC
        end
      end
    end
  end
end
