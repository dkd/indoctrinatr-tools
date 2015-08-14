module Indoctrinatr
  module Tools
    class DirectoryHelpers
      def initialize
        @dirtree_lines = []
      end

      # modified from http://compsci.ca/v3/viewtopic.php?t=13034
      def print_dirtree_style dir = '.', nesting = 2 # nesting starts with 2, because for \dirtree 1 is root
        Dir.foreach(dir) do |entry|
          next if entry =~ /^\.{1,2}/   # Ignore ".", "..", or hidden files
          @dirtree_lines.push ".#{nesting} #{entry}. ".to_latex # formatting for \dirtree: .<level><space><text-node>.<space>
          if File.stat(d = "#{dir}#{File::SEPARATOR}#{entry}").directory?
            print_dirtree_style(d, nesting + 1)
          end
        end
        @dirtree_lines
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
