require 'spec_helper'

describe Atm::Services::Dimension do
  let(:dimension) { Atm::Services::Dimension.new money }
  let(:amount) { 27 }

  let(:money) do
    [
      OpenStruct.new({ dimension: 1, amount: 100 }),
      OpenStruct.new({ dimension: 2, amount: 50 }),
      OpenStruct.new({ dimension: 5, amount: 20 }),
      OpenStruct.new({ dimension: 10, amount: 10 }),
      OpenStruct.new({ dimension: 25, amount: 4 }),
      OpenStruct.new({ dimension: 50, amount: 10 }),
    ]
  end

  describe 'structure' do
    it 'should return withdraw array' do
      withdraw = dimension.fetch amount
      assert_kind_of Array, withdraw
    end

    it 'should return Array of hashes with certain keys' do
      withdraw = dimension.fetch amount

      withdraw.each do |item|
        assert_equal [:amount, :dimension], item.keys
      end
    end

    describe 'when money is not enough' do
      let(:amount) { 2000 }

      it 'should return nil' do
        assert_nil dimension.fetch(amount)
      end
    end
  end

  describe 'Math' do
    def count_sum(withdraw)
      withdraw.reduce(0) do |acc, current|
        acc += current[:amount] * current[:dimension]
      end
    end

    describe 'should withdraw 417 points' do
      let(:amount) { 471 }
      let(:expect_withdraw) do
        [
          { amount: 9, dimension: 50 }, # 450
          { amount: 2, dimension: 10 }, # 470
          { amount: 1, dimension: 1 },  # 1
        ]
      end

      it 'should return correct amount' do
        withdraw = dimension.fetch amount
        assert_equal amount, count_sum(withdraw)
      end

      it 'should return correct withdraw object' do
        withdraw = dimension.fetch amount
        assert_equal expect_withdraw, withdraw
      end
    end

    describe 'should withdraw 727 points' do
      let(:amount) { 727 }

      let(:expect_withdraw) do
        [
          { amount: 10, dimension: 50 },  # 500
          { amount: 4, dimension: 25 },   # 600
          { amount: 10, dimension: 10 },  # 700
          { amount: 5, dimension: 5 },    # 725
          { amount: 1, dimension: 2 },    # 727
        ]
      end

      it 'should return correct amount' do
        withdraw = dimension.fetch amount
        assert_equal amount, count_sum(withdraw)
      end

      it 'should return correct withdraw object' do
        withdraw = dimension.fetch amount
        assert_equal expect_withdraw, withdraw
      end
    end

    describe 'should withdraw 50 points' do
      let(:amount) { 50 }

      let(:expect_withdraw) do
        [
          { amount: 1, dimension: 50 },  # 50
        ]
      end

      it 'should return correct amount' do
        withdraw = dimension.fetch amount
        assert_equal amount, count_sum(withdraw)
      end

      it 'should return correct withdraw object' do
        withdraw = dimension.fetch amount
        assert_equal expect_withdraw, withdraw
      end
    end

    describe 'should withdraw 15 points' do
      let(:amount) { 15 }

      let(:expect_withdraw) do
        [
          { amount: 1, dimension: 10 },  # 10
          { amount: 1, dimension: 5 },    # 15
        ]
      end

      it 'should return correct amount' do
        withdraw = dimension.fetch amount
        assert_equal amount, count_sum(withdraw)
      end

      it 'should return correct withdraw object' do
        withdraw = dimension.fetch amount
        assert_equal expect_withdraw, withdraw
      end
    end

    describe 'should withdraw 4 point' do
      let(:amount) { 4 }

      describe 'when banknotes dimension 2 exist' do
        let(:money) do
          [
            OpenStruct.new({ dimension: 1, amount: 4 }),
            OpenStruct.new({ dimension: 2, amount: 7 }),
            OpenStruct.new({ dimension: 5, amount: 8 }),
            OpenStruct.new({ dimension: 10, amount: 30 }),
            OpenStruct.new({ dimension: 25, amount: 25 }),
            OpenStruct.new({ dimension: 50, amount: 10 }),
          ]
        end

        let(:expect_withdraw) do
          [
            { amount: 2, dimension: 2 },
          ]
        end

        it 'should return correct amount' do
          withdraw = dimension.fetch amount
          assert_equal amount, count_sum(withdraw)
        end

        it 'should return correct withdraw object' do
          withdraw = dimension.fetch amount
          assert_equal expect_withdraw, withdraw
        end
      end

      describe 'when only one banknote dimension 2 exists' do
        let(:money) do
          [
            OpenStruct.new({ dimension: 1, amount: 4 }),
            OpenStruct.new({ dimension: 2, amount: 1 }),
            OpenStruct.new({ dimension: 5, amount: 8 }),
            OpenStruct.new({ dimension: 10, amount: 30 }),
            OpenStruct.new({ dimension: 25, amount: 25 }),
            OpenStruct.new({ dimension: 50, amount: 10 }),
          ]
        end

        let(:expect_withdraw) do
          [
            { amount: 1, dimension: 2 },
            { amount: 2, dimension: 1 },
          ]
        end

        it 'should return correct amount' do
          withdraw = dimension.fetch amount
          assert_equal amount, count_sum(withdraw)
        end

        it 'should return correct withdraw object' do
          withdraw = dimension.fetch amount
          assert_equal expect_withdraw, withdraw
        end
      end
    end
  end
end
