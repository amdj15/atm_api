module Api::Controllers::V1
  module Banknotes
    class Withdraw
      include Api::Action

      attr_reader :interaction

      def initialize
        @interaction = Atm::Interactions::WithdrawCash.new
      end

      def call(params)
        result = interaction.call(params.to_h[:amount].to_i)
        self.body = result.banknotes.to_json
      end
    end
  end
end
