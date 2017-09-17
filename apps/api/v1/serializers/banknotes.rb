module Api
  module Serializer
    module V1
      class Banknotes < Dry::Struct
        attribute :amount, Types::Int
        attribute :dimension, Types::Int
      end
    end
  end
end
