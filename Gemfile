source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "active_storage_validations", "0.8.2"
gem "aws-sdk-s3",              "1.46.0", require: false
gem "bcrypt", "3.1.13"
gem "bootsnap", ">= 1.4.5", require: false
gem "bootstrap-sass", "3.4.1"
gem "bootstrap-will_paginate", "1.0.0"
gem "faker", "2.1.2"
gem "geocoder"
gem "gmaps4rails"
gem "gretel", "3.0.9"
gem "http"
gem "image_processing", "1.9.3"
gem "jbuilder", "~> 2.9.1"
gem "jquery-rails"
gem "listen", "3.1.5"
gem "mini_magick", "4.9.5"
gem "mysql2"
gem "puma", "4.3.12"
gem "rails", "6.0.3"
gem "rails_12factor", group: :production
gem "rails-i18n"
gem "sass-rails", "5.1.0"
gem "turbolinks", "~> 5.2.0"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "webpacker", "~> 4.0.7"
gem "will_paginate", "3.1.8"

group :development, :test do
  gem "byebug", "11.0.1", platforms: %i[mri mingw x64_mingw]
  gem "capybara", "3.33.0"
  gem "capybara-screenshot", "1.0.24"
  gem "factory_bot_rails", "6.1.0"
  gem "launchy", "2.5.0"
  gem "rspec-rails", "~> 4.0"
  gem "selenium-webdriver", "3.142.4"
  gem "spring-commands-rspec"
end

group :development do
  gem "bcrypt_pbkdf"
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano-rbenv"
  gem "debase"
  gem "ed25519"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "ruby-debug-ide"
  gem "spring", "2.1.0"
  gem "spring-watcher-listen", "2.0.1"
  gem "web-console", "4.0.1"
end

group :test do
  gem "guard",                    "2.16.2"
  gem "guard-minitest",           "2.4.6"
  gem "minitest",                 "5.11.3"
  gem "minitest-reporters",       "1.3.8"
  gem "rails-controller-testing", "1.0.4"
end

group :production do
  gem "unicorn"
end
