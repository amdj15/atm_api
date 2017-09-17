module Api::Controllers::V1
  module Banknotes
    class Create
      include Api::Action
      include Api::ParamsMapper
      include Api::Controllers::V1::Responder

      attr_reader :interaction

      def initialize
        @interaction = Atm::Interactions::IncreaseCash.new
      end

      def call(params)
        result = interaction.call symbolize_keys[params.to_h]

        if result.successful?
          respond result.banknotes, serializer: Api::Serializer::V1::Banknotes
        else
          respond result.error, status: result.error.status,
                                serializer: Api::Serializer::V1::Error
        end
      end
    end
  end
end
