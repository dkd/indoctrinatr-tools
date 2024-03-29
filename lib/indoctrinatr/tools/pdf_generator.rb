# Unify the command usage for all pdf creation features
module Indoctrinatr
  module Tools
    module PdfGenerator
      # Compiles a PDF from a tex file with XeLaTeX
      # @param tex_file a Pathname that points to the tex file
      # @return false if error, nil if system command unknown
      def make_pdf(tex_file, output_dir = nil, cleanup: true)
        args = ['-xelatex',
                '-shell-escape',
                '-interaction=batchmode', # more silent output
                "-output-directory=#{output_dir}", # without this xelatex tries to use the current working directory
                tex_file.to_s]
        if output_dir.nil?
          args.delete_at 3 # Remove argument if no output dir is wished for. This probably could be done better.
        end
        latexmk_successful = system('latexmk', *args) # latexmk instead of running 2.times
        latex_cleanup output_dir if latexmk_successful && cleanup
        latexmk_successful
      end

      # Cleans up LaTeX helper files in a specific directory
      # @param working_directory a Pathname that points the directory that should get cleaned up
      # @return false if error, nil if system command unknown
      def latex_cleanup(working_directory)
        # latexmk -c apparently cannot cleanup a specified subdirectory. So we have to change the working directory,
        # run the cleanup command in it and then change back to the directory that we were in. http://tex.stackexchange.com/q/301366/17834
        current_dir = Dir.getwd
        Dir.chdir working_directory.to_s if working_directory
        latexmk_successful = system 'latexmk -c'
        Dir.chdir current_dir # should be the same as ../../.. # Dir.chdir '../../..'
        latexmk_successful
      end
    end
  end
end
