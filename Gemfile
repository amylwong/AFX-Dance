source 'https://rubygems.org'

ruby '2.2.2'

gem "puma"

gem "cancan"
gem 'pry'

gem 'activeadmin', '1.0.0.pre2'
gem 'devise'
#gem "meta_search", '>= 1.1.0.pre'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :test do
  gem 'coveralls', :require => false
  gem 'simplecov', :require => false
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels', :require => false
  gem 'rspec-rails', :require => false
  gem 'database_cleaner', :require => false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

# making your Gemfile safe for Heroku
group :development, :test do
  # make sure sqlite3 gem ONLY occurs inside development & test groups
  gem 'sqlite3' # use SQLite only in development and testing
end 
group :production do
  # make sure the following gems are in your production group:
  gem 'pg'              # use PostgreSQL in production (Heroku)
  gem 'rails_12factor'  # Heroku-specific production settings
end

end

