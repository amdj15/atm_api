module Atm
  module Errors
    class NotEnoughCash < BaseError
      def title
        'Not enough money in ATM'
      end

      def status
        400
      end
    end
  end
end
