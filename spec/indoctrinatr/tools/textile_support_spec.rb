require 'spec_helper'

context "when supporting Textile with 'textilize' function" do
  let(:configuration) do
    c = Indoctrinatr::Tools::TemplatePackConfiguration.new
    c.attributes_as_hashes_in_array = []
    c.template_asset_path = ''
    c.output_file_name = ''
    c
  end
  let(:default_values) { Indoctrinatr::Tools::DefaultValues.new configuration }

  it 'parses to LaTeX' do
    expect(default_values.textile2latex('*strong*')).to eq "\\textbf{strong}\n\n"
  end
end
