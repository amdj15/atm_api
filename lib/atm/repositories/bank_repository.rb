class BankRepository < Hanami::Repository
  def update_balance(withdraw)
    dimensions = withdraw.reduce({}) do |acc, current|
      acc[current[:dimension]] = current
      acc
    end

    models = banks.where(dimension: dimensions.keys).to_a

    transaction do
      models.map do |model|
        amount = model.amount - dimensions[model.dimension][:amount]
        update(model.id, amount: amount)
      end
    end
  end
end
