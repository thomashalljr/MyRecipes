source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.7.3"

gem "bcrypt", "~> 3.1.7"
gem "bootstrap", "~> 4.4.1"
gem "carrierwave", "~> 1.0"
gem "cloudinary", "1.9.1"
gem "coffee-rails", "~> 4.2"
gem "devise", "~> 4.2"
gem "ffi", ">= 1.9.24"
gem "figaro"
gem "font-awesome-sass", "~> 5.12.0"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "loofah", ">= 2.2.3"
gem "nokogiri", "~> 1.13.10"
gem "puma", "~> 3.7"
gem "rack", ">= 2.0.6"
gem "rails", "~> 5.1.6"
gem "ransack"
gem "react-rails"
gem "rubyzip", ">= 1.2.2"
gem "sassc", "2.1.0"
gem "sass-rails", "~> 5.0"
gem "sprockets", ">= 3.7.2"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "webpacker", "~> 3.5"
gem "will_paginate", "3.1.0"
gem "will_paginate-bootstrap4"

group :development, :test do
  gem "byebug"
  gem "capybara", "~> 2.13"
  gem "rails-controller-testing"
  gem "rubocop", "~> 1.24"
  gem "rubocop-rails", "~> 2.13"
  gem "rubocop-minitest"
  gem "standard"
  gem "selenium-webdriver"
  gem "sqlite3"
end

group :development do
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "pg"
  gem "redis"
end
