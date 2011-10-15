require 'capybara/rspec'

require File.join(File.dirname(__FILE__), *%w[app set_cookie])
Capybara.app = Sinatra::Application

require 'show_me_the_cookies'
RSpec.configure do |config|
  config.include ShowMeTheCookies, :type => :request
end