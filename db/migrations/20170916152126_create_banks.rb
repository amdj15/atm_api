Hanami::Model.migration do
  change do
    create_table :banks do
      primary_key :id

      column :amount, Integer
      column :dimension, Integer

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
