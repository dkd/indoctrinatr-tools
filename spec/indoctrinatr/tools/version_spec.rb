require 'spec_helper'
require_relative '../../../lib/indoctrinatr/tools/version'

describe 'Indoctrinatr::Tools' do
  it 'defines a VERSION constant' do
    expect(Indoctrinatr::Tools::VERSION).to eq '0.17.0'
  end
end
