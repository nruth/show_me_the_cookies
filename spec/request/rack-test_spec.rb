require 'spec_helper'

describe "RackTest", :type => :request do
  before(:each) do
    Capybara.current_driver = :rack_test
  end

  describe "the testing rig" do
    it "should load the sinatra app" do
      visit '/'
      page.should have_content("Cookie setter ready")
    end
  end

  describe "API" do
    describe "inspect_cookies" do
      it "returns a driver-dependent string summary of the session cookie's k/v pairs" do
        visit '/set/foo/bar'
        page.should have_content("Setting foo=bar")
        inspect_cookies.should match /foo=bar/
        visit '/set/myopic/mice'
        page.should have_content("Setting myopic=mice")
        inspect_cookies.should match /myopic=mice/
      end
    end

    describe "delete_cookie(cookie_name)" do
      it "deletes a k/v pair from the session cookie" do
        visit '/set/choc/milk'
        visit '/set/extras/hazlenut'
        inspect_cookies.should match /extras=hazlenut/
        inspect_cookies.should match /choc=milk/
        visit '/delete/choc'
        page.should have_content("Deleting choc")
        inspect_cookies.should match /extras=hazlenut/
        inspect_cookies.should_not match /choc=milk/
      end
    end
  end
end