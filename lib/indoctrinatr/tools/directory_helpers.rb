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

      # default file types for template docs
      def list_files_of_type directory = '.', types = %w[erb rb yaml sty tex]
        # found and modified from http://stackoverflow.com/a/3504307/1796645
        Dir.glob("#{directory}/**/*.{#{types.join(',')}}") # recursively list files of type in types array
      end
    end
  end
end
