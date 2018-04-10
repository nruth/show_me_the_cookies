source "http://rubygems.org"

# Specify your gem's dependencies in show_me_the_cookies.gemspec
gemspec

gem 'rake' # for releases

group :test do
  gem 'rspec', '~> 3.0'
  gem 'poltergeist', git: 'https://github.com/teampoltergeist/poltergeist', ref: 'f822d3a'
  gem 'sinatra'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper' # chromedriver installer
  gem 'capybara-webkit'
end
