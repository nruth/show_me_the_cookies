require 'spec_helper'
require 'shared_examples_for_api'
require 'capybara-webkit'

describe 'Webkit', type: :feature do
  before(:each) do
    Capybara.current_driver = :webkit
    page.driver.allow_url('subdomain.lvh.me')
  end

  describe 'the testing rig' do
    it 'should load the sinatra app' do
      visit '/'
      expect(page).to have_content('Cookie setter ready')
    end
  end

  it_behaves_like 'the API'
end
