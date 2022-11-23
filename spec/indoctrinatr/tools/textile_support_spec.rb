require 'spec_helper'
require 'redcloth'
require_relative '../../../lib/redcloth/formatters/latex'
require_relative '../../../lib/indoctrinatr/tools/template_pack_configuration'
require_relative '../../../lib/indoctrinatr/tools/content_for_tex_files'
require_relative '../../../lib/indoctrinatr/tools/default_values'

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
