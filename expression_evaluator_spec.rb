require 'rspec'
require_relative 'expression_evaluator'
require 'json'
require 'pry'

describe ExpressionEvaluator do
  subject { ExpressionEvaluator.new(data, expression).data_matches_expression? }
  context 'simple true expression/data' do
    let(:data) { {'country' => 'usa'} }
    let(:expression) { JSON.generate({'=' => {'country' => 'usa'}}) }
    it { is_expected.to be_truthy }
  end

  context 'simple false expression/data' do
    let(:data) { {'country' => 'usa'} }
    let(:expression) { JSON.generate({'=' => {'country' => 'iran'}}) }
    it { is_expected.to be_falsy }
  end

  context 'and expression' do
    let(:data) { {'country' => 'usa', 'os_version' => '6.1.1'} }
    let(:expression) { JSON.generate({'and' => [{'=' => {'country' => 'usa'}},
                                                {'=' => {'os_version' => '6.1.1'}}]}) }
    it { is_expected.to be_truthy }
  end

  context 'not expression' do
    let(:data) { {'country' => 'usa', 'os_version' => '6.1.1'} }
    let(:expression) { JSON.generate({'not' => [{'=' => {'country' => 'iran'}}]})}
    it { is_expected.to be_truthy }
  end

  context 'or expression' do
    let(:data) { {'country' => 'usa', 'os_version' => '6.1.1'} }
    let(:expression) { JSON.generate({'or' => [{'=' => {'country' => 'iran'}},
                                               {'=' => {'os_version' => '6.1.1'}}]})}
    it { is_expected.to be_truthy }
  end

  context 'complex expression' do
    let(:data) { {'country' => 'usa',
                  'os_version' => '6.1.1',
                  'language' => 'english',
                  'app_version' => '0.2'} }
    let(:expression) { JSON.generate({'and' =>
                                      [{'or' =>
                                        [{'=' => {'country' => 'usa'}},
                                         {'=' => {'language' => 'spanish'}}]},
                                       {'not' =>
                                         [{'or' =>
                                          [{'=' => {'app_version' => '0.2'}},
                                           {'=' => {'os_version' => '7.0.0'}}]}]}]}) }
    it { is_expected.to be_falsy }
  end

  context 'arbitrary properties' do
    let(:data) {{'purchase' => 'true'}}
    let(:expression) { JSON.generate({'=' => {'purchase' => 'true'}})}
    it { is_expected.to be_truthy }
  end

  context 'booleans' do
    let(:data) {{'purchase' => true}}
    let(:expression) { JSON.generate({'=' => {'purchase' => true}}) }
    it { is_expected.to be_truthy }
  end

  context 'ints' do
    let(:data) {{'num_purchases' => 5}}
    let(:expression) { JSON.generate({'=' => {'num_purchases' => 5}}) }
    it { is_expected.to be_truthy }
  end

  context 'floats' do
    let(:data) {{'satisfaction' => 0.54}}
    let(:expression) { JSON.generate({'=' => {'satisfaction' => 0.54}}) }
    it { is_expected.to be_truthy }
  end

  context 'empty string' do
    let(:data) {{'country' => 'usa'}}
    let(:expression) { JSON.generate({'=' => {'language' => ''}}) }
    it { is_expected.to be_falsy }
  end

  context 'multiple ands' do
    let(:data) { {'country' => 'usa',
                  'os_version' => '6.1.1',
                  'language' => 'english',
                  'app_version' => '0.2'} }
    let(:expression) { JSON.generate({'and' => [{'=' => {'country' => 'usa'}},
                                                {'=' => {'os_version' => '6.1.1'}},
                                                {'=' => {'language' => 'spanish'}}]}) }
    it { is_expected.to be_falsy }
  end

  context '> operator' do
    let(:data) { {'num_purchases' => 4} }
    let(:expression) { JSON.generate({ '>' => {'num_purchases' => 5} } ) }
    it { is_expected.to be_falsy }
  end

  context '< operator' do
    let(:data) { {'num_purchases' => 4} }
    let(:expression) { JSON.generate({ '<' => {'num_purchases' => 5} } ) }
    it { is_expected.to be_truthy }
  end
end