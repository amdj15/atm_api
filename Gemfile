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
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'byebug'
end

group :test do
  gem 'minitest'
  gem 'capybara'
  gem 'hanami-fabrication'
end

group :production do
  gem 'puma'
end
