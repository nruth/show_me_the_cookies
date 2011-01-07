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

  def self.session_cookie_name=(name)
    @@session_cookie_name = name
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

  # Rails.application.config.session_options[:key] #for rails 3, courtesy of https://github.com/ilpoldo
  #else just hard code it as follows
  #'_appname_session' #or check in browser for what your app is using
  def session_cookie_name
    begin
      @@session_cookie_name || Rails.application.config.session_options[:key]
    rescue NoMethodError => e
      raise "set ShowMeTheCookies.session_cookie_name= for your rails 2 app"
    end
  end
end