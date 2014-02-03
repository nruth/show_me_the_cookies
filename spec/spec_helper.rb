require 'capybara/rspec'

require File.join(File.dirname(__FILE__), *%w[app set_cookie])
Capybara.app = Sinatra::Application

# requires entry in /etc/hosts file:
# 127.0.0.1 localhost.local.com
Capybara.server_port = 36363
Capybara.app_host = "http://localhost.local.com:#{Capybara.server_port}"

require 'show_me_the_cookies'
RSpec.configure do |config|
  config.include ShowMeTheCookies, :type => :feature
end