require 'spec_helper'
require 'shared_examples_for_api'
require 'capybara-webkit'
require 'pry'

describe "Webkit", :type => :feature do
  before(:each) do
    Capybara.current_driver = :webkit
  end

  describe "the testing rig" do
    it "should load the sinatra app" do
      visit '/'
      page.should have_content("Cookie setter ready")
    end
  end

  it_behaves_like "the API"
end
