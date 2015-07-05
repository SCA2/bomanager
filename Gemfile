source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'haml-rails', '~> 0.9.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap-sass'
gem 'bootstrap_form'

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'spring'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'fabrication'
  gem 'faker'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov', require: false
  gem 'webmock', '~> 1.21.0'
end

group :production do
  gem 'rails_12factor'
end