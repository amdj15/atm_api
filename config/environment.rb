require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/atm'
require_relative '../apps/api/application'

Hanami.configure do
  mount Api::Application, at: '/api'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/app_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/app_development'
    #    adapter :sql, 'mysql://localhost/app_development'
    #
    adapter :sql, ENV['DATABASE_URL']

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json
  end
end
