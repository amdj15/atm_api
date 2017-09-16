module Helpers
  module Mock
    def new_mock
      mock = Minitest::Mock.new
      yield mock

      mock
    end
  end
end
