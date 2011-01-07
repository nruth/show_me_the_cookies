Show me the cookies
===================

Some helpers for cucumber stepdefs (or other situations) where you want to find out what is going on with your browser cookies.

Original development took place when testing Devise 0.1's "Remember me" functionality under rails 2.3.x with capybara rack-test and/or selenium.

Rails session cookies look something like '\_appname\_session', and can be found with browser resource tracker (e.g. firebug) or using rails 3's Rails.application.config.session_options[:key]

Credits and Acknowledgements
==================================

Initial release as a gist [here](https://gist.github.com/484787), early development sponsored by [Medify](www.medify.co.uk).

Contributions have been made by:

  * [Leandro Pedroni](https://github.com/ilpoldo) -- Rails 3 session cookie detection (no longer in the code but present in readme)
  * [Matthew Nielsen](https://github.com/xunker) -- added culerity support & encouraged gem release


Example Usage
=============

Feature
-------

    @javascript @announce
    Scenario: remembering users so they don't have to log in again for a while
      Given an activated member exists with forename: "Paul", surname: "Smith", email: "paul_smith_91@gmail.com", password: "bananabanana"
      When I go to the dashboard
      Then I should see "Existing Member Login"
      When I fill in "Email" with "paul_smith_91@gmail.com" within "#member_login"
      And I fill in "Password" with "bananabanana" within "#member_login"
      And I check "Remember me"
      And I press "Sign in"
      Then I should be on the dashboard
      And I should see "Logged in as Paul Smith"
      And I should see "Sign out"

      Given I close my browser (clearing the Medify session)
      When I come back next time
      And I go to the dashboard
      Then I should see "Logged in as Paul Smith"
      And I should see "Sign out"

    @rack_test @announce
    Scenario: don't remember users across browser restarts if they don't want it
      Given an activated member exists with forename: "Paul", surname: "Smith", email: "paul_smith_91@gmail.com", password: "bananabanana"
      When I go to the dashboard
      Then I should see "Existing Member Login"
      When I fill in "Email" with "paul_smith_91@gmail.com" within "#member_login"
      And I fill in "Password" with "bananabanana" within "#member_login"
      And I uncheck "Remember me"
      And I press "Sign in"
      Then I should be on the dashboard
      And I should see "Logged in as Paul Smith"
      And I should see "Sign out"

      Given I close my browser (clearing the Medify session)
      When I come back next time
      And I go to the dashboard
      Then I should see "Existing Member Login"
      And I should not see "Logged in as Paul Smith"
      And I should not see "Sign out"

gem install
-----------
gem install show\_me\_the\_cookies, or whatever fits your situation.

stepdef file
------------

call it whatever you like, mine is called cookie_steps.rb

    Then /^show me the cookies!$/ do
      show_me_the_cookies
    end

    Given /^I close my browser \(clearing the Medify session\)$/ do
      delete_cookie '_medify_session' # or in rails 3 use Rails.application.config.session_options[:key]
    end

    World(ShowMeTheCookies)
    Before('@announce') do
      @announce = true
    end

Contributing
============

Code-style comments, refactoring, tests and new features welcome (roughly in that order :).

When sending changes:

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
============
Copyright (c) 2011 Nicholas Rutherford. See LICENSE.txt for
further details.

