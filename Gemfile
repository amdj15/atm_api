source 'https://rubygems.org'

ruby '2.4.1'

gem 'pg'

gem 'rake'
gem 'hanami',       '~> 1.0'
gem 'hanami-model', '~> 1.0'

gem 'dry-types'
gem 'dry-struct'
gem 'dry-auto_inject'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
  gem 'rubocop', require: false
  gem 'danger-gitlab', require: false
  gem 'danger-lgtm', require: false
  gem 'danger-rubocop', require: false
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'pry'
end

group :test do
  gem 'minitest'
  gem 'capybara'
  gem 'hanami-fabrication'
  gem 'm'
end

group :production do
  gem 'puma'
end
