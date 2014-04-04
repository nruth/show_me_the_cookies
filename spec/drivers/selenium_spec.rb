require 'spec_helper'
require 'shared_examples_for_api'

describe "Selenium Webdriver", :type => :feature do
  before(:each) do
    Capybara.current_driver = :selenium
  end

  describe "the testing rig" do
    it "should load the sinatra app" do
      visit '/'
      page.should have_content("Cookie setter ready")
    end
  end

  it_behaves_like "the API"

  it "raises an exception when writing a cookie before visiting the app" do
    expect {create_cookie('choc', 'milk')}.to raise_error(ShowMeTheCookies::Selenium::SiteNotVisitedError)
  end
end

describe "options", type: :feature do
  # around(:each) do |example|
  #   port = Capybara.server_port
  #   host = Capybara.app_host
  #   # requires entry in /etc/hosts file:
  #   # 127.0.0.1 localhost.local.com
  #   Capybara.server_port = 36363
  #   Capybara.app_host = "http://localhost.local.com:#{Capybara.server_port}"
  #   example.run
  #   Capybara.server_port = port
  #   Capybara.app_host = host
  # end
  it "creates a cookie with path and domain" do
    # need to first hit a page to set a cookie (selenium)
    visit("/")
    create_cookie("choc", "milk", path: "/", domain: ".local.com")
    cookies_should_contain("choc", "milk")

    visit("/get/choc")
    page.should have_content("Got cookie choc=milk")

    visit '/set_with_domain/choc/doublemilk'
    cookies_should_contain("choc", "doublemilk")
    cookies_should_not_contain('choc', 'milk')

    visit("/get/choc")
    page.should have_content("Got cookie choc=doublemilk")
  end
end