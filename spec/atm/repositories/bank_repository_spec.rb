require 'spec_helper'

describe BankRepository do
  let(:repository) { BankRepository.new }

  describe '#update_balance' do
    before do
      repository.clear

      [1, 2, 5, 10, 25, 50].each do |dem|
        Fabricate(:bank) do
          dimension { dem }
          amount { 10 }
        end
      end
    end

    let(:withdraw) do
      [
        { dimension: 5, amount: 2 },
        { dimension: 25, amount: 2 },
      ]
    end

    it 'should withdraw correct amount of given dimensions' do
      entities = repository.update_balance(withdraw)

      entities.each do |money|
        assert_equal 8, money.amount
      end
    end
  end
end
