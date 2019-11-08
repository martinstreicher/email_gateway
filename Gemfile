# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'active_type'
gem 'awesome_print'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'coffee-rails', '~> 4.2'
gem 'draper'
gem 'interactor'
gem 'jbuilder', '~> 2.7'
gem 'memery', github: 'tycooon/memery', branch: 'master'
gem 'montrose'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.1'
gem 'rake'
gem 'recursive-open-struct'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'table_print'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'wannabe_bool'
gem 'webpacker', '~> 4.0'
gem 'zeitwerk'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-migrate'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'guard-yield'
  gem 'thin'
  gem 'timecop'
  gem 'uuid'
end

group :development do
  gem 'bundler-audit'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'rubocop-faker'
  gem 'rubocop-ordered_methods'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-thread_safety'
  gem 'test-prof'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'rspec'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'shoulda'
end
