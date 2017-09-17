module Atm
  module Interactions
    class IncreaseCash
      include Interactor
      include Atm::Inject[
        repository: 'repositories.bank',
        schema: 'schemas.inrease_cash',
        validation_error_class: 'errors.validation'
      ]

      def call(params)
        valid(schema, params) do
          if params[:banknotes].any?
            success banknotes: repository.increase_balance(params[:banknotes])
          else
            failure validation_error_class.new({ banknotes: ['Can\'t be balnk'] })
          end
        end
      end
    end
  end
end
