module Atm
  module Schemas
    Withdraw = Dry::Validation.Schema do
      required(:amount).filled(:int?, gt?: 0)
    end
  end
end
