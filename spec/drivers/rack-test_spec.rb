require 'spec_helper'
require 'shared_examples_for_api'

RSpec.describe 'RackTest', type: :feature do
  before(:each) do
    Capybara.current_driver = :rack_test
  end

  describe 'the testing rig' do
    it 'should load the sinatra app' do
      visit '/'
      expect(page).to have_content('Cookie setter ready')
    end
  end

  it_behaves_like 'the API'
end
