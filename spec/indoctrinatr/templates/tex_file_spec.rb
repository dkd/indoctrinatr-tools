require 'spec_helper'
require 'pathname'

context 'with template.tex.erb' do
  it 'exists' do
    template_file = Pathname.new(__FILE__).join '..', '..', '..', '..', 'lib', 'indoctrinatr', 'templates', 'template.tex.erb'
    expect(File.exist?(template_file)).to be true
  end
end
