require 'spec_helper'

describe "RackTest", :type => :request do
  before(:each) do
    Capybara.app = Sinatra::Application
    Capybara.current_driver = :rack_test
  end

  describe "the testing rig" do
    it "should load the sinatra app" do
      visit '/'
      page.should have_content("Cookie setter ready")
    end
  end

  describe "show_me_the_cookies" do
    it "returns a driver-dependent string summary of the session cookies" do
      visit '/foo/bar'
      page.should have_content("Setting foo=bar")
      inspect_cookies.should =~ /foo=bar/
      visit '/myopic/mice'
      page.should have_content("Setting myopic=mice")
      inspect_cookies.should =~ /myopic=mice/
    end
  end
end