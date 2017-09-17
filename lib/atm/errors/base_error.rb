module Atm
  module Errors
    class BaseError < StandardError
      attr_reader :title, :status, :meta

      def initialize
        @title = nil
        @status = 500
        @meta = []
      end

      def to_hash
        {
          title: title,
          status: status,
          meta: meta,
        }
      end
    end
  end
end
