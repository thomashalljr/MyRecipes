source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.7.3'

gem 'rails', '~> 5.1.6'
gem 'bootstrap', '~> 4.4.1'
gem 'jquery-rails'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'will_paginate', '3.1.0'
gem 'will_paginate-bootstrap4'
gem 'webpacker', '~> 3.5'
gem 'react-rails'
gem 'carrierwave', '~> 1.0'
gem 'cloudinary', '1.9.1'
gem 'nokogiri', '~> 1.10.1'
gem 'rubyzip', '>= 1.2.2'
gem 'ffi', '>= 1.9.24'
gem 'sprockets', '>= 3.7.2'
gem 'rack', '>= 2.0.6'
gem 'loofah', '>= 2.2.3'
gem 'devise', '~> 4.2'
gem 'figaro'
gem 'ransack'
gem 'font-awesome-sass', '~> 5.12.0'

group :development, :test do
  gem 'byebug'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'sqlite3'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
end

group :production do
  gem 'pg'
  gem 'redis'
end
