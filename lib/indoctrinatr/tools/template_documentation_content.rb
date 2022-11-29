module Indoctrinatr
  module Tools
    class TemplateDocumentationContent < ContentForTexFiles
      attr_accessor :template_pack_name, :list_of_files

      # Overwrite the initialize method because the content is built up much more complex than for the other
      # ContentForTexFile children.
      def initialize(template_pack_name, configuration)
        super(configuration)

        @configuration = configuration
        @template_pack_name = template_pack_name
        @list_of_files = print_dirtree_style @template_pack_name
        @attributes = configuration.attributes_as_hashes_in_array # we need: name, presentation, default_value, description
        @template_name = configuration.template_name
        @files = read_template_files_content
        @default_values_pdf_path = default_values_example
        @pdf_with_field_names_path = fieldname_values_example
      end

      private

      def read_template_files_content
        filenames = list_files_of_type template_pack_name
        path_name = Pathname.new(Dir.pwd).join template_pack_name
        pack_documentation_dir_path = path_name.join 'doc'
        pack_documentation_examples_dir_path = pack_documentation_dir_path.join 'examples'
        filenames.reject! { |f| f.include?(pack_documentation_examples_dir_path.relative_path_from(Pathname.new(Dir.pwd)).to_s) }
        filenames.inject [] do |files, filename|
          files.push TemplateDocumentationSourceFile.new filename
        end
      end

      def default_values_example
        TemplatePackDefaultValuesParser.new.call(@template_pack_name) do |result|
          result.success do |message|
            puts message
            TemplatePackDefaultValuesCompiler.new.call(template_pack_name:, keep_aux_files: false) do |result2|
              result2.success do |message2|
                puts message2
              end
              result2.failure do |message2|
                puts message2
              end
            end
            pdf_with_default_values_file_path
          end
          result.failure do |message|
            puts message
          end
        end
      end

      # get file path for PDF example with default values:
      def pdf_with_default_values_file_path
        path_name = Pathname.new(Dir.pwd).join template_pack_name
        pack_documentation_dir_path = path_name.join 'doc'
        pack_documentation_examples_dir_path = pack_documentation_dir_path.join 'examples'
        default_values = DefaultValues.new @configuration
        # if there is a change in where the pdf command (DefaultValuesCompiler) saves it's output, this logic needs to be updated
        if default_values.customized_output_file_name == default_values.default_file_name
          Pathname.new(Dir.pwd).join pack_documentation_examples_dir_path + default_values.customized_output_file_name
        else
          Pathname.new(Dir.pwd).join pack_documentation_examples_dir_path + eval("\"#{default_values.output_file_name}\"", binding, __FILE__, __LINE__) # rubocop:disable Security/Eval
          # usage of eval to execute the interpolation of a custom filename string with interpolation - e.g. a filename with the current date
        end
      end

      def fieldname_values_example
        # This gives user the option to customize the FieldNameValues Example that is appended in the documentation
        path_name = Pathname.new(Dir.pwd).join template_pack_name
        fail 'Please specify a template pack name.' if template_pack_name.empty? # rubocop:disable Style/SignalException
        fail "A folder with name '#{template_pack_name}' does not exist." unless Dir.exist? path_name.to_s # rubocop:disable Style/SignalException

        pack_documentation_dir_path = path_name.join 'doc'
        pack_documentation_examples_dir_path = pack_documentation_dir_path.join 'examples'
        pdf_with_fieldname_values_file_path = "#{pack_documentation_examples_dir_path.join template_pack_name}_with_fieldname_values.pdf"

        return pdf_with_fieldname_values_file_path if File.exist? pdf_with_fieldname_values_file_path

        TemplatePackFieldnamesCreator.new.call(template_pack_name:, keep_aux_files: false) do |result|
          result.success do
            puts 'INFO: Example with field names has been automatically generated for the documentation' # More user information and for testing
            pdf_with_fieldname_values_file_path
          end
          result.failure do |message|
            puts message
            puts 'ERROR: Example with field names could not be created and is not included in documentation'
            nil
          end
        end
      end

      # refractored from directory_helpers.rb author: Luka Lüdicke
      def print_dirtree_style(directory = '.')
        Dir.glob("#{directory}/**/*").inject [] do |entries, entry| # list entries recursively
          nesting = entry.count(File::SEPARATOR) + 1 # nesting starts with 2, because for \dirtree 1 is root
          name = entry.split(File::SEPARATOR).last
          entries.push ".#{nesting} #{name}. " # formatting for \dirtree: .<level><space><text-node>.<space>
        end
      end

      # refractored from directory_helpers.rb author: Luka Lüdicke
      # default file types for template docs
      def list_files_of_type(directory = '.', types = %w[erb rb yaml sty tex])
        # found and modified from http://stackoverflow.com/a/3504307/1796645
        Dir.glob("#{directory}/**/*.{#{types.join(',')}}") # recursively list files of type in types array
      end
    end
  end
end
