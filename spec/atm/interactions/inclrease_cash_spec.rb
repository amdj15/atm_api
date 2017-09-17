require 'spec_helper'

describe Atm::Interactions::IncreaseCash do
  let(:interaction) { Atm::Interactions::IncreaseCash.new repository: repo }
  let(:repo) do
    new_mock do |mock|
      mock.expect :increase_balance, nil, [Array]
    end
  end

  let(:params) do
    {
      banknotes: [
        { dimension: 25, amount: 2 },
        { dimension: 50, amount: 2 },
      ]
    }
  end

  it 'should increase cash amount in repository' do
    result = interaction.call params
    repo.verify
  end

  it 'should return successful result' do
    result = interaction.call params
    assert_equal true, result.successful?
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
