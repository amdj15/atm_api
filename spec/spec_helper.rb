# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'

require 'ostruct'
require_relative '../config/environment'
require 'minitest/autorun'

require_relative 'support/helpers/mock'

class MiniTest::Spec
  include Helpers::Mock
end

Hanami.boot
