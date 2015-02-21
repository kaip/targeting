require 'rspec'
require_relative 'runner'
require 'json'
require 'pry'

describe Runner do
  subject { Runner.new(data, expression).data_matches_expression? }
  context 'simple true expression/data' do
    let(:data) { {'country' => 'usa'} }
    let(:expression) { JSON.generate({country: 'usa'}) }
    it { is_expected.to be_truthy }
  end

  context 'simple false expression/data' do
    let(:data) { {'country' => 'usa'} }
    let(:expression) { JSON.generate({country: 'iran'}) }
    it { is_expected.to be_falsy }
  end
end