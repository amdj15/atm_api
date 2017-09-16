module Atm
  module Services
    class Dimension
      def initialize(money)
        @money = money.sort { |a, b| b.dimension <=> a.dimension }
      end

      def fetch(amount)
        sum = 0

        withdraw = @money.map do |money|
          bank_notes_cnt = fetch_dimension(money.clone, amount - sum)
          sum += bank_notes_cnt * money.dimension

          { amount: bank_notes_cnt, dimension: money.dimension }
        end

        sum < amount ? nil : withdraw.select { |money| money[:amount] > 0 }
      end

      private

      def fetch_dimension(money, amount)
        sum = 0
        count = 0

        while sum < amount && money.amount > 0 do
          sum += money.dimension
          break if sum > amount

          money.amount -= 1
          count += 1
        end

        count
      end
    end
  end
end
