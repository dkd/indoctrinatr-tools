describe 'configuration.yaml' do
  it 'should exist' do
    configuration_file = Pathname.new(__FILE__).join '..', '..', '..', '..', 'lib', 'indoctrinatr', 'templates', 'configuration.yaml' 
    expect(File.exists? configuration_file).to eq true
  end
end