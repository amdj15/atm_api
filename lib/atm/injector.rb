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
    end

    namespace 'schemas' do
      register('withdraw_params') { Atm::Schemas::Withdraw }
    end
  end

  Inject = Dry::AutoInject(Container)
end
