source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# server
gem 'mysql2', '>= 0.4.4', '< 0.6.0', group: :development
gem 'pg', group: :production
gem 'puma', '~> 3.11'
# view
gem 'bootstrap'
gem 'bootstrap-social-rails'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'popper_js'
gem 'sass-rails', '~> 5.0'
gem 'tether-rails'
gem 'uglifier', '>= 1.3.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'gon'

# login
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-line'

gem 'payjp'
gem 'rails_12factor', group: :production
gem 'resources_id_replace'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'overcommit'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end
