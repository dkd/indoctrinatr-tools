require 'indoctrinatr/tools/default_values'

describe "support for Textile with 'textilize' function" do
  let(:default_values) { Indoctrinatr::Tools::DefaultValues.new }

  it 'parses to LaTeX' do
    expect(default_values.textilize('*strong*')).to eq "\\textbf{strong}\n\n"
  end
end
