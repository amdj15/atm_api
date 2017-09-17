module Api
  module Serializer
    module V1
      class Error < Dry::Struct
        attribute :status, Types::Int
        attribute :title, Types::String
        attribute :meta, Types::Hash
      end
    end
  end
end
