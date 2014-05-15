module Indoctrinatr
  module Tools
    class TemplatePackScaffold
      attr_reader :template_name, :path_name

      def initialize template_name
        @template_name = template_name
        @path_name = Pathname.new(Dir.pwd).join template_name
      end

      def call
        if Dir.exists? path_name
          raise "A folder with name #{template_name} already exists."
        else
          Dir.mkdir path_name          
        end
      end
    end
  end
end
