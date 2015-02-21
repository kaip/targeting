require 'rspec'
require_relative 'runner'
require 'json'

describe Runner do
  subject { Runner.new(data, expression).data_matches_expression? }
  context 'simple true expression/data' do
    let(:data) { {country: 'usa'} }
    let(:expression) { JSON.generate({country: 'usa'}) }
    it { is_expected.to be_truthy }
  end
end