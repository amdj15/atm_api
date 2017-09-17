require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

task default: :test
task spec: :test

task set_bank: :environment do
  repository = BankRepository.new
  repository.clear

  Bank::ALLOWED_DIMENSIONS.each do |dimension|
    repository.create dimension: dimension, amount: 10
  end
end
