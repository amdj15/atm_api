module Api
  module ParamsMapper
    def symbolize_keys
      lambda do |item|
        if Hash === item
          Hash[item.map { |k, v| [k.respond_to?(:to_sym) ? k.to_sym : k, symbolize_keys[v]] }]
        elsif Array === item
          item.map { |i| symbolize_keys[i] }
        else
          item
        end
      end
    end
  end
end
