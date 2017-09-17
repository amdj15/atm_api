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
          return failure validation_error_class.new({
            banknotes: ['Can\'t be balnk']
          }) if params[:banknotes].empty?


          missed, existed = fetch_dimensions(params[:banknotes])

          banknotes = []
          banknotes += create missed
          banknotes += update existed

          success banknotes: banknotes
        end
      end

      private

      def update(dimensions)
        repository.increase_balance dimensions
      end

      def create(dimensions)
        dimensions.map do |item|
          repository.create item
        end
      end

      def fetch_dimensions(money)
        dimensions = money.map { |b| b[:dimension] }
        banknotes = repository.fetch_by_dimensions(dimensions)

        money.reduce([[], []]) do |acc, current|
          if banknotes[current[:dimension]].nil?
            acc[0] << current
          else
            acc[1] << current
          end

          acc
        end
      end
    end
  end
end
