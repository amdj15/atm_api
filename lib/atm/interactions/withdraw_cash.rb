module Atm
  module Interactions
    class WithdrawCash
      include Interactor
      include Atm::Inject[
        dimensions_class: 'services.dimensions',
        repository: 'repositories.bank',
        not_enough_cash_error: 'errors.not_enough_cash_error',
        schema: 'schemas.withdraw_params'
      ]

      def call(amount)
        valid(schema, amount: amount) do
          bank = repository.all
          dimensions = dimensions_class.new bank

          withdraw = dimensions.fetch(amount)

          return failure(not_enough_cash_error) if withdraw.nil?

          repository.decrease_balance withdraw
          success banknotes: withdraw
        end
      end
    end
  end
end
