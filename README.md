Show me the cookies
===================

Some helpers for cucumber stepdefs (or other situations) where you want to find out what is going on with your browser cookies.

Original development took place when testing Devise 0.1's "Remember me" functionality under rails 2.3.x with capybara rack-test and/or selenium.

Rails session cookies look something like '\_appname\_session', and can be found with browser resource tracker (e.g. firebug) or using rails 3's Rails.application.config.session_options[:key]

Credits and Acknowledgements
==================================

Initial release as a gist [here](https://gist.github.com/484787), early development sponsored by [Medify](http://www.medify.co.uk).

Contributions have been made by:

  * [Leandro Pedroni](https://github.com/ilpoldo) -- Rails 3 session cookie detection (no longer in the code but present in readme)
  * [Matthew Nielsen](https://github.com/xunker) -- added culerity support & encouraged gem release

gem install
-----------
gem install show\_me\_the\_cookies, or whatever fits your situation.

RSpec
=====

in step_helper or your support directory:

    RSpec.configure do |config|
      config.include ShowMeTheCookies, :type => :request
    end

Example usage
--------------


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
      delete_cookie Rails.application.config.session_options[:key]

      #     When I come back next time
      visit dashboard_path
      page.should have_content("Dashboard")
      page.should have_no_content("Login")
    end


Cucumber
========

Install by loading the gem and adding the following to your stepdefs or support files

    World(ShowMeTheCookies)
    Before('@announce') do
      @announce = true
    end

Example Usage
-------------

    @javascript @announce
    Scenario: remembering users so they don't have to log in again for a while
      Given I am a site member
      When I go to the dashboard
      And I log in with the Remember Me option checked
      Then I should see "Welcome back"
      
      When I close my browser (clearing the session)
      And I return to the dashboard url
      Then I should see "Welcome back"

    @rack_test @announce
    Scenario: don't remember users across browser restarts if they don't want it
      Given I am a site member
      When I go to the dashboard
      And I log in without the Remember Me option checked
      Then I should see "Welcome back"
    
      When I close my browser (clearing the session)
      And I return to the dashboard url
      Then I should see the log-in screen


stepdef file
------------

for example cookie_steps.rb

    Then /^show me the cookies!$/ do
      show_me_the_cookies
    end

    Given /^I close my browser \(clearing the Medify session\)$/ do
      delete_cookie '_appname_session' # or in rails 3 use Rails.application.config.session_options[:key]
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

