source 'https://rubygems.org'

source 'https://rails-assets.org' do
  gem 'rails-assets-plugin'
end

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'webpacker', '~> 5.x'

gem 'geocoder'

gem "bootstrap-sass"
# gem 'bootstrap', '~> 4.4.1'
gem 'font-awesome-sass', '~> 5.6.1'
gem "simple_form"
gem "autoprefixer-rails"

gem 'figaro'

gem 'devise', '~> 4.6'
gem 'devise-i18n'
gem 'pundit'

gem "simple_calendar", "~> 2.0"
# https://github.com/excid3/simple_calendar

gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'
# https://github.com/TrevorS/bootstrap3-datetimepicker-rails

ruby '2.7.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'pg_search'
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "letter_opener", group: :development
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'cloudinary'
gem 'carrierwave', '~>1.3'

# Gemfile for Rails 3+, Sinatra, or Merb
gem 'will_paginate', '~> 3.1.1'
gem 'dotenv-rails', groups: [:development, :test]
group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end


group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
