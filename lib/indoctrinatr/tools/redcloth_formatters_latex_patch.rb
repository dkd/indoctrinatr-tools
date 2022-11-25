require 'redcloth'

module Indoctrinatr
  module Tools
    module RedclothFormattersLatexPatch
      def self.apply
        const = Kernel.const_get('RedCloth::Formatters::LATEX')
        const&.prepend(self)
      rescue NameError => e
        puts e
      end

      {
        h1: 'chapter',
        h2: 'section',
        h3: 'subsection',
        h4: 'subsubsection',
        h5: 'subparagraph',
        h6: 'textbf'
      }.each do |m, tag|
        define_method(m) do |opts|
          case opts[:align]
          when 'left'
            "\\begin{flushleft}\\#{tag}{#{opts[:text]}}\\end{flushleft}\n\n"
          when 'right'
            "\\begin{flushright}\\#{tag}{#{opts[:text]}}\\end{flushright}\n\n"
          when 'center'
            "\\begin{center}\\#{tag}{#{opts[:text]}}\\end{center}\n\n"
          else
            "\\#{tag}{#{opts[:text]}}\n\n"
          end
        end
      end

      def del(opts)
        "\\st{#{opts[:text]}}"
      end
    end
  end
end
