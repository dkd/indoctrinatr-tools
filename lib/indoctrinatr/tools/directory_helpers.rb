module Indoctrinatr
  module Tools
    module DirectoryHelpers
      def print_dirtree_style directory = '.'
        Dir.glob("#{directory}/**/*").inject [] do |entries, entry| # list entries recursively
          nesting = entry.count(File::SEPARATOR) + 1 # nesting starts with 2, because for \dirtree 1 is root
          name = entry.split(File::SEPARATOR).last
          entries.push ".#{nesting} #{name}. " # formatting for \dirtree: .<level><space><text-node>.<space>
        end
      end

      def list_files_of_type directory = '.', types = %w(erb rb yaml sty tex) # default file types for template docs
        # found and modified from http://stackoverflow.com/a/3504307/1796645
        Dir.glob("#{directory}/**/*.{#{types.join(',')}}") # recursively list files of type in types array
      end

      def get_programming_language path_to_file
        case File.extname(path_to_file)
        when '.tex'
          language = 'TeX'
        when '.sty'
          language = 'TeX'
        when '.erb' # .erb files are just supposed to be tex.erb files. TODO: more correct
          language = 'TeX'
        when '.rb'
          language = 'Ruby'
        else # probably YAML
          language = 'unspecified'
        end
        language
      end
    end
  end
end
