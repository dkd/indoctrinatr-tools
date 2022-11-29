module Indoctrinatr
  module Tools
    class CommandAutocompleteHelpers
      def self.handle_autocomplete(path)
        path.gsub(%r{(.*)(/$|\\$)}, '\1')
      end
    end
  end
end
