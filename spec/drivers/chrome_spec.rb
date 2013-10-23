require 'spec_helper'
require 'shared_examples_for_api'

describe "Chromedriver", :type => :feature do
  before(:each) do
    Capybara.register_driver :chrome do |app|
      # on mac you can use homebrew:
      #   brew install chromedriver
      # or get it directly from::
      #   http://chromedriver.storage.googleapis.com/index.html?path=2.4/
      # Make sure chromedriver is in your PATH
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
    Capybara.current_driver = :chrome
  end

  describe "the testing rig" do
    it "should load the sinatra app" do
      visit '/'
      page.should have_content("Cookie setter ready")
    end
  end

  it_behaves_like "the API"
end
