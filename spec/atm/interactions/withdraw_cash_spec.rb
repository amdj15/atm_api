require 'spec_helper'

describe Atm::Interactions::WithdrawCash do
  let(:interaction) { Atm::Interactions::WithdrawCash.new repository: repository }

  let(:repository) do
    new_mock do |mock|
      mock.expect :all, bank
      mock.expect :update_balance, nil, [Array]
    end
  end

  let(:bank) do
    [
      OpenStruct.new({ dimension: 25, amount: 4 }),
      OpenStruct.new({ dimension: 50, amount: 10 })
    ]
  end

  describe 'when amount is not valid' do
    it 'should has failed result' do
      result = interaction.call 'amount'
      assert_equal true, result.failed?
    end

    it 'should has failed result' do
      result = interaction.call '200'
      assert_equal true, result.failed?
    end
  end

  describe 'when it\'s enough cash in ATM' do
    let(:amount) { 225 }

    let(:expected_banknotes) do
      [
        { amount: 4, dimension: 50 },
        { amount: 1, dimension: 25 }
      ]
    end

    it 'should has successful response' do
      result = interaction.call amount
      assert_equal true, result.successful?
    end

    it 'should update balance of money in database' do
      result = interaction.call amount
      repository.verify
    end

    it 'should has correnct banknotes' do
      result = interaction.call amount

      assert_equal expected_banknotes, result.banknotes
    end
  end

  describe 'when it\'s not enough money in ATM' do
    let(:amount) { 1000 }

    it 'should has failed result' do
      result = interaction.call amount
      assert_equal false, result.successful?
    end

    it 'should has error' do
      result = interaction.call amount
      assert_kind_of Atm::Errors::NotEnoughCash, result.error
    end
  end
end
