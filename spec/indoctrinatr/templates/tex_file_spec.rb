describe 'template.tex.erb' do
  it 'should exist' do
    template_file = Pathname.new(__FILE__).join '..', '..', '..', '..', 'lib', 'indoctrinatr', 'templates', 'template.tex.erb'
    expect(File.exists? template_file).to eq true
  end
end
