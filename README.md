# Show me the cookies

Some helpers for poking around at your Capybara driven browser's cookies in integration tests.

Supports Capybara's bundled drivers (rack-test, Selenium Webdriver), and adapters for other
drivers may be added (at time of writing Akephalos is also available).

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
API spec should not be changed because something doesn't work – try to fix the driver, or make an addon gem.

More tests are welcome.

## Installation

Add to your gemfile's test group:

    gem "show_me_the_cookies"


## RSpec

in step_helper or your support directory:

    RSpec.configure do |config|
      config.include ShowMeTheCookies, :type => :feature
    end

### Example usage

In a request spec, using [Capybara](https://github.com/jnicklas/capybara)

    specify "user login is remembered across browser restarts" do
      log_in_as_user
      should_be_logged_in
      #browser restart = session cookie is lost
      expire_cookies
      should_be_logged_in
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
      show_me_the_cookies
    end

    Then /^show me the "([^"]*)" cookie$/ do |cookie_name|
      show_me_the_cookie(cookie_name)
    end

    Given /^I close my browser \(clearing the session\)$/ do
      expire_cookies
    end

## History, Credits, and Acknowledgements

[Contributors](https://github.com/nruth/show_me_the_cookies/contributors)

Original development took place when testing Devise 0.1's "Remember me" functionality under rails 2.3.x with capybara rack-test and/or selenium.
Initial release as a gist [here](https://gist.github.com/484787), early development sponsored by [Medify](http://www.medify.co.uk).

Contributions outside of github have been made by:

  * [Leandro Pedroni](https://github.com/ilpoldo)
  * [Matthew Nielsen](https://github.com/xunker)
