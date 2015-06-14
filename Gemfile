source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'haml-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'bcrypt', '~> 3.1.7'

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  # gem 'byebug'
  # gem 'web-console', '~> 2.0'
  gem 'pry'
  gem 'pry-nav'
  gem 'spring'
end

group :test do
  gem 'fabrication'
  gem 'faker'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'capybara'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end