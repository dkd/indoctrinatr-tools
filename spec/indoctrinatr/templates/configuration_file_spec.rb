require 'spec_helper'
require 'pathname'

context 'with configuration.yaml' do
  it 'exists' do
    configuration_file = Pathname.new(__FILE__).join '..', '..', '..', '..', 'lib', 'indoctrinatr', 'templates', 'configuration.yaml'
    expect(File.exist?(configuration_file)).to eq true
  end
end
