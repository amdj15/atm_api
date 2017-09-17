module Atm
  module Schemas
    IncreaseCash = Dry::Validation.Schema do
      required(:banknotes).each do
        required(:dimension).filled(included_in?: Bank::ALLOWED_DIMENSIONS)
        required(:amount).filled(:int?, gt?: 0)
      end
    end
  end
end
