require 'spec_helper'
require_relative '../../../lib/indoctrinatr/tools/redcloth_formatters_latex_patch'
require_relative '../../../lib/indoctrinatr/tools/template_pack_configuration'
require_relative '../../../lib/indoctrinatr/tools/content_for_tex_files'
require_relative '../../../lib/indoctrinatr/tools/default_values'

context "when supporting Textile with 'textilize' function" do
  before { Indoctrinatr::Tools::RedclothFormattersLatexPatch.apply }

  let(:configuration) do
    Indoctrinatr::Tools::TemplatePackConfiguration.new.tap do |config|
      config.attributes_as_hashes_in_array = []
      config.template_asset_path = ''
      config.output_file_name = ''
    end
  end
  let(:default_values) { Indoctrinatr::Tools::DefaultValues.new configuration }

  it 'parses Textile ** to LaTeX textbf' do
    expect(default_values.textile2latex('*strong text*')).to eq "\\textbf{strong text}\n\n"
  end
end
