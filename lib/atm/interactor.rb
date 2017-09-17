module Atm
  module Interactions
    module Interactor
      def success(data = {})
        Result.new success: true, meta: data
      end

      def failure(error = nil)
        Result.new success: false, meta: { error: error }
      end

      def valid(schema, params)
        validation_result = schema.call params

        if validation_result.failure?
          return failure Errors::Validation.new(validation_result.errors)
        end

        yield
      end

      class Result
        def initialize(success:, meta:)
          @success = success
          @meta = meta
        end

        def successful?
          @success == true
        end

        def failed?
          @success != true
        end

        def method_missing(name, *)
          @meta[name] || super
        end
      end
    end
  end
end
