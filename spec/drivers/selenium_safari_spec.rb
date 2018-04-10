require 'spec_helper'
require 'shared_examples_for_api'
require 'selenium-webdriver'

Capybara.register_driver :selenium_safari do |app|
  Capybara::Selenium::Driver.new(
    app, browser: :safari,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.safari({})
  )
end

RSpec.describe 'Selenium Webdriver Safari', type: :feature do
  before(:each) do
    Capybara.current_driver = :selenium_safari
  end

  describe 'the testing rig' do
    it 'should load the sinatra app' do
      visit '/'
      expect(page).to have_content('Cookie setter ready')
    end
  end

  it_behaves_like 'the API'

  it 'raises an exception when writing a cookie before visiting the app' do
    expect { create_cookie('choc', 'milk') }.to(
      raise_error(ShowMeTheCookies::SeleniumSiteNotVisitedError)
    )
  end
end
