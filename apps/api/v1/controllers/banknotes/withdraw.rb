module Api::Controllers::V1
  module Banknotes
    class Withdraw
      include Api::Action
      include Api::Controllers::V1::Responder

      attr_reader :interaction

      def initialize
        @interaction = Atm::Interactions::WithdrawCash.new
      end

      def call(params)
        result = interaction.call(params.to_h[:amount].to_i)

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
