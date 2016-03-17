# Unify the command usage for all pdf creation features
module Indoctrinatr
  module Tools
    module PdfGenerator
      # Compiles a PDF from a tex file with XeLaTeX
      # @param tex_file a Pathname that points to the tex file
      # @return false if error, nil if system command unknown
      def make_pdf tex_file, output_dir = nil
        args = ['-xelatex',
                '-shell-escape',
                '-interaction=batchmode', # more silent output
                "-output-directory=#{output_dir}", # without this xelatex tries to use the current working directory
                tex_file.to_s]
        if output_dir.nil?
          args.delete_at 3 # Remove argument if no output dir is wished for. This probably could be done better.
        end
        latexmk_successful = system('latexmk', *args) # latexmk instead of running 2.times
        latexmk_successful
      end
    end
  end
end
