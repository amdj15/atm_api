module Api
  module Controllers
    module V1
      module Responder
        def respond(entity, status: 200, serializer: nil)
          key = status < 400 ? :data : :error

          self.status = status
          self.body = JSON.generate(Hash[key, build_body(entity, serializer)])
        end

        private

        def build_body(entity, serializer)
          return serializer.new(entity).to_h unless entity.is_a? Array

          entity.map do |ent|
            serializer.new(ent).to_h
          end
        end
      end
    end
  end
end
