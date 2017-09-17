require 'spec_helper'

describe Atm::Interactions::IncreaseCash do
  let(:interaction) { Atm::Interactions::IncreaseCash.new repository: repo }

  let(:params) do
    {
      banknotes: [
        { dimension: 50, amount: 2 },
      ]
    }
  end

  let(:repo) do
    new_mock do |mock|
      mock.expect :increase_balance, [], [Array]
      mock.expect :fetch_by_dimensions, Hash.new, [Array]
      mock.expect :create, Bank.new, [Hash]
    end
  end

  let(:banknotes) { Bank.new({ dimension: 50, amount: 2 }) }

  it 'should increase cash amount in repository' do
    result = interaction.call params
    repo.verify
  end

  it 'should return successful result' do
    result = interaction.call params
    assert_equal true, result.successful?
  end

  it 'should has correct result' do
    result = interaction.call params

    assert_kind_of Array, result.banknotes
    assert_equal [banknotes], result.banknotes
  end

  describe 'when params are invalid' do
    it 'should return failed result objec' do
      result = interaction.call({})
      assert_equal true, result.failed?
    end

    it 'should return validation error' do
      result = interaction.call({})
      assert_kind_of Atm::Errors::Validation, result.error
    end

    it 'should return validation error when banknotes are empty' do
      result = interaction.call banknotes: []
      assert_kind_of Atm::Errors::Validation, result.error
    end
  end
end
