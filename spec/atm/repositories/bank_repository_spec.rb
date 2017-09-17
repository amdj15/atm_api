require 'spec_helper'

describe BankRepository do
  let(:repository) { BankRepository.new }

  before do
    repository.clear

    Bank::ALLOWED_DIMENSIONS.each do |dem|
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

  describe '#decrease_balance' do
    it 'should withdraw correct amount of given dimensions' do
      entities = repository.decrease_balance(withdraw)

      entities.each do |money|
        assert_equal 8, money.amount
      end
    end
  end

  describe '#increase_balance' do
    it 'should increase correctly amount of given dimensions' do
      entities = repository.increase_balance(withdraw)

      entities.each do |money|
        assert_equal 12, money.amount
      end
    end
  end

  describe '#fetch_by_dimensions' do
    let(:dimensions) { [5, 10] }

    describe 'when nothing is found' do
      before do
        repository.clear
      end

      it 'should return empty hash' do
        result = repository.fetch_by_dimensions(dimensions)
        assert_equal Hash.new, result
      end
    end

    describe 'when dimensions exists' do
      it 'should return hash of dimensions with correct keys' do
        result = repository.fetch_by_dimensions(dimensions)
        assert_equal [5, 10], result.keys
      end
    end
  end
end
