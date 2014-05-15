module Indoctrinatr
  module Tools
    class TemplatePackScaffold
      def initialize template_name
        path_name = Pathname.new(Dir.pwd).join template_name
        if Dir.exists? path_name
          raise "A folder with name #{template_name} already exists."
        else
          Dir.mkdir path_name          
        end
      end
    end
  end
end
