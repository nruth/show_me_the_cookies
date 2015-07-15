require 'spec_helper'
require 'shared_examples_for_api'
require 'capybara/mechanize'

Capybara::Mechanize.local_hosts << "subdomain.lvh.me"

describe 'Mechanize', type: :feature do
  around(:each) do |example|
    # mechanize will think that our app is remote if we set Capybara.app_host, which is not what we want
    app_host, Capybara.app_host = Capybara.app_host, nil
    example.run
    Capybara.app_host = app_host
  end

  before(:each) do
    Capybara.current_driver = :mechanize
  end

  describe 'the testing rig' do
    it 'should load the sinatra app' do
      visit '/'
      expect(page).to have_content('Cookie setter ready')
    end
  end

  describe 'get_me_the_cookie' do
    it 'reads httponly option' do
      visit '/set_httponly/foo/bar'
      expect(get_me_the_cookie('foo')).to include(
        name: 'foo', value: 'bar', httponly: true
      )
    end
  end

  it_behaves_like 'the API'
end
