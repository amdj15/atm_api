module Atm
  module Errors
    class Validation < BaseError
      attr_reader :meta

      def initialize(meta)
        @meta = meta
      end

      def title
        'Validation error'
      end

      def status
        422
      end

      def to_hash
        {
          title: title,
          status: status,
          meta: meta
        }
      end
    end
  end
end
