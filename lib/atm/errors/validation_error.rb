module Atm
  module Errors
    class Validation < BaseError
      def initialize(meta)
        @meta = meta
      end

      def title
        'Validation error'
      end

      def status
        422
      end
    end
  end
end
