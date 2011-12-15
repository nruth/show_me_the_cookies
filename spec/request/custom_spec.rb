require 'spec_helper'
require 'shared_examples_for_api'

describe "Custom Webdriver", :type => :request do
  before(:all) do
    Capybara.register_driver :custom do |app|
      Capybara::Selenium::Driver.new(app, :resynchronize => true)
    end
  end
  before(:each) do
    Capybara.current_driver = :custom
  end

  describe "the testing rig" do
    it "should load the sinatra app" do
      visit '/'
      page.should have_content("Cookie setter ready")
    end
  end

  it_behaves_like "the API"
end
