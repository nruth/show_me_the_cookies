source "http://rubygems.org"

# Specify your gem's dependencies in show_me_the_cookies.gemspec
gemspec

gem 'rake' # for releases

group :test do
  gem 'rspec', '~> 3.0'
  gem 'sinatra'
  gem 'cuprite'
  gem 'selenium-webdriver'
  gem 'webdrivers', require: false # chromedriver installer
  gem 'webrick' if RUBY_VERSION >= '3'
end
