# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'haml'
gem 'httparty', '~> 0.13.7'
gem 'jbuilder', '~> 2.7'
gem 'omniauth-spotify'
gem 'paperclip', '~> 6.0.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.1'
gem 'redis'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'pry', '~> 0.12.2'
  gem 'pry-nav'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.79.0', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
