# Show me the cookies

Some helpers for poking around at your browser's cookies in integration tests.

## API

    inspect_cookies # Returns a string summarising your current session cookie's k/v pairs,
                    # so you can see what's going on.
    
    delete_cookie "key" # Deletes a particular k/v pair from your session cookie.
    
    expire_cookies # Removes cookies which are either due to expire, or have no expiry set.

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

## Contributing

Use github issues for discussion. Contributions via small, testable (preferably tested), pull requests.

Code-style comments, refactoring, tests and new features welcome (roughly in that order :).

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
