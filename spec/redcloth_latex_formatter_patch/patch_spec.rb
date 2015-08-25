require 'spec_helper'
require 'redcloth_latex_formatter_patch/patch'

describe 'patches for RedCloth::LATEX::Formatter' do
  it 'tranforms a h1. headline to LaTeX chapter notation' do
    text = 'h1. Headline'
    expect(RedCloth.new(text).to_latex).to eq "\\chapter{Headline}\n\n"
  end

  it 'tranforms a h2. headline to LaTeX section notation' do
    text = 'h2. Headline'
    expect(RedCloth.new(text).to_latex).to eq "\\section{Headline}\n\n"
  end

  it 'tranforms a h3. headline to LaTeX subsection notation' do
    text = 'h3. Headline'
    expect(RedCloth.new(text).to_latex).to eq "\\subsection{Headline}\n\n"
  end

  it 'tranforms a h4. headline to LaTeX subsubsection notation' do
    text = 'h4. Headline'
    expect(RedCloth.new(text).to_latex).to eq "\\subsubsection{Headline}\n\n"
  end

  it 'transforms a table to LaTeX tabu notation' do
    input = "|_.Headerspalte 1|_.Headerspalte 2|\n|Feld 1,1        |Feld 2,1        |\n|Feld 1,2        |Feld 2,2        |"
    expected_result = "\\begin{tabu}{ l l }\n    Headerspalte 1 & Headerspalte 2 \\\\\n    Feld 1,1         & Feld 2,1         \\\\\n    Feld 1,2         & Feld 2,2         \\\\\n\\end{tabu}\n"
    expect(RedCloth.new(input).to_latex).to eq expected_result
  end
end
