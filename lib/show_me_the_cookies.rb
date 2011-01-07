module ShowMeTheCookies

  require 'show_me_the_cookies/culerity'
  require 'show_me_the_cookies/rack_test'
  require 'show_me_the_cookies/selenium'

  def current_driver_adapter
    case (current_driver = Capybara.current_session.driver)
    when Capybara::Driver::Selenium
      ShowMeTheCookies::Selenium.new(current_driver.browser)
    when Capybara::Driver::RackTest
      ShowMeTheCookies::RackTest.new(current_driver)
    when Capybara::Driver::Culerity
      ShowMeTheCookies::Culerity.new(current_driver.browser)
    else
      unsupported_driver_spam
    end
  end

  def show_me_the_cookies
    announce "Current cookies: #{current_driver_adapter.show_me_the_cookies}"
  end

  def delete_cookie(cookie_name)
    announce current_driver_adapter.show_me_the_cookies if @announce
    current_driver_adapter.delete_cookie(cookie_name)
    announce "Deleted cookie: #{cookie_name}" if @announce
    announce current_driver_adapter.show_me_the_cookies if @announce
  end

private
  @@session_cookie_name = nil

  def self.unsupported_browser_spam
    raise "unsupported driver, use rack::test, selenium/webdriver or culerity"
  end
end