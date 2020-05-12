# 5.0.1

## Gem development dependencies
chromedriver-helper -> webdrivers. Bundler -> 2.0.2. Should not affect your app.

# 5.0

## Capybara-webkit removed

Due to obsolescence and maintenance difficulty.
Setting up capybara-webkit and qt has never been fun, but now it's getting
silly: According to the [capybara-webkit wiki](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit) Qt has removed the necessary webkit bindings, and homebrew has removed the old version of qt that still had them.

New / current projects should switch to headless Chrome or Firefox with webdriver, which will work with the existing adapters, but if you need the webkit driver for legacy apps stick with version 4, or copy the adapter from version 4 into your app's test support code.

## Chrome and Firefox driver names

Drivers are now registered matching the names used by [capybara](https://github.com/teamcapybara/capybara):

:selenium => Selenium driving Firefox
:selenium_headless => Selenium driving Firefox in a headless configuration
:selenium_chrome => Selenium driving Chrome
:selenium_chrome_headless => Selenium driving Chrome in a headless configuration

# 4.0

Changes some cookie escaping logic & supports capybara 3.

For more information see the release commit: [cc0a1106d9cb00827aeda3301f5b75d6d10e80ba](https://github.com/nruth/show_me_the_cookies/commit/cc0a1106d9cb00827aeda3301f5b75d6d10e80ba)
