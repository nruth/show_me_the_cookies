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
