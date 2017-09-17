class BankRepository < Hanami::Repository
  def decrease_balance(data)
    update_balance(data) do |model, dimensions|
      model.amount - dimensions[model.dimension][:amount]
    end
  end

  def increase_balance(data)
    update_balance(data) do |model, dimensions|
      model.amount + dimensions[model.dimension][:amount]
    end
  end

  def fetch_by_dimensions(dimensions)
    banks.where(dimension: dimensions).to_a.reduce({}) do |acc, current|
      acc[current.dimension] = current
      acc
    end
  end

  private

  def update_balance(banknotes)
    dimensions = banknotes.reduce({}) do |acc, current|
      acc[current[:dimension]] = current
      acc
    end

    models = banks.where(dimension: dimensions.keys).to_a

    transaction do
      models.map do |model|
        amount = yield model, dimensions
        update(model.id, amount: amount)
      end
    end
  end
end
