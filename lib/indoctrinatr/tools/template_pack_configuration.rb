module Indoctrinatr
  module Tools
    # wrapper class for config. See ConfigurationExtractor for details
    class TemplatePackConfiguration
      attr_accessor :template_asset_path, :default_file_name, :template_name, :textual_description, :output_file_name, :attributes_as_hashes_in_array
    end
  end
end
