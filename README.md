# Show me the cookies

Some helpers for poking around at your Capybara driven browser's cookies in integration tests.

## API

      # puts a string summary of the cookie
      show_me_the_cookie(cookie_name)
      
      # returns a hash of the cookie
      # form: {:name, :domain, :value, :expires, :path}
      get_me_the_cookie(cookie_name)
      
      # puts a string summary of all cookies
      show_me_the_cookies
      
      # returns an array of cookie hashes
      # form: [{:name, :domain, :value, :expires, :path}]
      get_me_the_cookies
      
      # deletes the named cookie
      delete_cookie(cookie_name)
      
      # removes session cookies and expired persistent cookies
      expire_cookies

## Contributing

If you find this useful, the best way to say thanks is to take a poke around the code and send feedback upstream.
Bugs / requests / suggestions should be raised in the [Github issues](https://github.com/nruth/show_me_the_cookies/issues) tracker.

Code contributions should be sent by github pull request, or contact [me](https://github.com/nruth) with a link 
to your repository branch.
Patches should be small, isolated, testable, and preferably tested.

New drivers should be accompanied by a passing API spec. 
Driver-specific edge cases should not be added to the shared spec unless thought to be of general interest.
API spec should not be changed because something doesn't work, fix the driver or make a plugin gem.

More tests are welcome.

## Installation

Add to your gemfile's test group:

gem "show\_me\_the\_cookies"


## RSpec

in step_helper or your support directory:

    RSpec.configure do |config|
      config.include ShowMeTheCookies, :type => :request
    end

### Example usage

In a request spec, using [Capybara](https://github.com/jnicklas/capybara)

    it "remember-me is on by default" do
      member = Member.make
      visit dashboard_path
      page.should have_content "Login"
      within '#member_login' do
        fill_in "Email", :with => member.email
        fill_in "Password", :with => member.password
        click_on "Sign in"
      end
  
      page.should have_content("Dashboard")
      page.should have_no_content("Login")
      #     Given I close my browser (clearing the session)
      expire_cookies

      #     When I come back next time
      visit dashboard_path
      page.should have_content("Dashboard")
      page.should have_no_content("Login")
    end


## Cucumber


Install by loading the gem and adding the following to your stepdefs or support files

    World(ShowMeTheCookies)

### Features

    @javascript
    Scenario: remembering users so they don't have to log in again for a while
      Given I am a site member
      When I go to the dashboard
      And I log in with the Remember Me option checked
      Then I should see "Welcome back"
      
      When I close my browser (clearing the session)
      And I return to the dashboard url
      Then I should see "Welcome back"

    @rack_test
    Scenario: don't remember users across browser restarts if they don't want it
      Given I am a site member
      When I go to the dashboard
      And I log in without the Remember Me option checked
      Then I should see "Welcome back"
    
      When I close my browser (clearing the session)
      And I return to the dashboard url
      Then I should see the log-in screen


### Stepdefs

    Then /^show me the cookies!$/ do
      puts inspect_cookies
    end

    Given /^I close my browser \(clearing the session\)$/ do
      expire_cookies
    end

## Addendum

At time of writing, Rails session cookies looked something like '\_appname\_session', 
and can be found with browser resource tracker (e.g. firebug) or using Rails 3's 
Rails.application.config.session_options[:key]

## History, Credits, and Acknowledgements

Original development took place when testing Devise 0.1's "Remember me" functionality under rails 2.3.x with capybara rack-test and/or selenium.

Initial release as a gist [here](https://gist.github.com/484787), early development sponsored by [Medify](http://www.medify.co.uk).

Contributions outside of github have been made by:

  * [Leandro Pedroni](https://github.com/ilpoldo) -- Rails 3 session cookie detection (no longer in the code but present in readme)
  * [Matthew Nielsen](https://github.com/xunker) -- added culerity support & encouraged gem release
