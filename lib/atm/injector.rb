module Atm
  class Container
    extend Dry::Container::Mixin

    namespace 'services' do
      register('dimensions') { Atm::Services::Dimension }
    end

    namespace 'repositories' do
      register('bank') { BankRepository.new }
    end

    namespace 'errors' do
      register('not_enough_cash_error') { Atm::Errors::NotEnoughCash.new }
      register('validation') { Atm::Errors::Validation }
    end

    namespace 'schemas' do
      register('withdraw_params') { Atm::Schemas::Withdraw }
      register('inrease_cash') { Atm::Schemas::IncreaseCash }
    end
  end

  Inject = Dry::AutoInject(Container)
end
