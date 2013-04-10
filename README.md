# Show me the cookies

Some helpers for poking around at your Capybara driven browser's cookies in integration tests.

Supports Capybara's bundled drivers (rack-test, Selenium Webdriver) and Poltergeist (PhantomJS).
You may add new drivers for your application by implementing an adapter class and calling ShowMeTheCookies.register_adapter in your test code (e.g. a spec/support file).

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


### Installing your own drivers

Register your adapter class in your test setup after loading the library.

    ShowMeTheCookies.register_adapter(driver, adapter)

for example

    ShowMeTheCookies.register_adapter(:custom_selenium_a, ShowMeTheCookies::Selenium)

which indicates how to use the selenium adapter with a custom selenium testing profile.

## Contributing

If you find this useful some ways to say thanks are reviewing the code and/or kind words or other feedback by Github message.
Bugs should be raised in the [issue tracker](https://github.com/nruth/show_me_the_cookies/issues).

Code contributions should be sent as Github pull requests, or by messaging [me](https://github.com/nruth) with a link
to your repository branch. Please run the tests, and add new ones.

New drivers are unlikely to be accepted at this stage. You can instead add them to your application's test setup. 
If you come up with an interesting new driver/adapter mail me with a link to a repository or gist and I'll link to it here.
Hopefully the API shared-spec will come in useful when working on your own driver.


## History, Credits, and Acknowledgements

[Contributors](https://github.com/nruth/show_me_the_cookies/contributors)

Original development took place when testing Devise 0.1's "Remember me" functionality under rails 2.3.x with capybara rack-test and/or selenium.
Initial release as a gist [here](https://gist.github.com/484787), early development sponsored by [Medify](http://www.medify.co.uk).

Contributions outside of github have been made by:

  * [Leandro Pedroni](https://github.com/ilpoldo)
  * [Matthew Nielsen](https://github.com/xunker)
