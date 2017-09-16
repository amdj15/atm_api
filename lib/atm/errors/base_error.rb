module Atm
  module Errors
    class BaseError < StandardError
      attr_reader :title, :status

      def initialize
        @title = nil
        @status = 500
      end

      def to_hash
        {
          title: title,
          status: status
        }
      end
    end
  end
end
