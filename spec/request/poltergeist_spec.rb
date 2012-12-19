require 'spec_helper'
require 'shared_examples_for_api'
require 'capybara/poltergeist'

describe "Poltergeist", :type => :request do
  before(:each) do
    Capybara.current_driver = :poltergeist
  end

  describe "the testing rig" do
    it "should load the sinatra app" do
      visit '/'
      page.should have_content("Cookie setter ready")
    end
  end

  it_behaves_like "the API"
end
