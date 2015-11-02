source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
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
# Turbolinks makes following links in your web application faster.
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Authorization
gem 'devise'
gem 'devise-i18n'
gem 'devise-bootstrap-views'

# Simplify form
gem 'simple_form'

# Frontend dependencies manager
gem 'bower-rails'

# Paginator
gem 'will_paginate', '~> 3.0.6'
gem 'will_paginate-bootstrap'

# Internalization
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master'
gem 'i18n-active_record',
    :git => 'git://github.com/svenfuchs/i18n-active_record.git',
    :require => 'i18n/active_record'

# File uploader
gem 'dragonfly', '~> 1.0.12'

group :development do
  # Open email in separate browser tab
  gem 'letter_opener'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application
  # running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Use Rspec instead of Minitests
  gem 'rspec-rails'
  # Bootstap rspec a little bit
  gem 'spring-commands-rspec'
  group :darwin do
    gem 'rb-fsevent', :require => false
  end
end

group :test do
  # Feature (user emulator) tests
  gem 'capybara'
  # Drivers for capybara
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  # Factory for tests
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rspec-collection_matchers'
end

group :production do
  gem 'puma'
  gem 'rack-cache', :require => 'rack/cache'
end

