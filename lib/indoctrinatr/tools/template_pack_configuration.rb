module Indoctrinatr
  module Tools
    class TemplatePackConfiguration # wrapper class for config. See ConfigurationExtractor for details
      attr_accessor :template_asset_path, :default_file_name, :template_name, :textual_description, :output_file_name, :attributes_as_hashes_in_array
    end
  end
end
