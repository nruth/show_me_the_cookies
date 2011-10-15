module ShowMeTheCookies
  require 'show_me_the_cookies/rack_test'
  require 'show_me_the_cookies/selenium'

  # return a string summary of all cookies
  def inspect_cookies
    current_driver_adapter.show_me_the_cookies
  end

  def show_me_the_cookies
    warn "DEPRECATION: show_me_the_cookies -- use inspect_cookies to grab the string and puts yourself"
    puts "Current cookies: #{inspect_cookies}"
  end

  # deletes the named cookie
  def delete_cookie(cookie_name)
    current_driver_adapter.delete_cookie(cookie_name)
  end

  # removes session cookies and expired persistent cookies
  def expire_cookies
    current_driver_adapter.expire_cookies
  end

private
  @@session_cookie_name = nil
  
  def current_driver_adapter
    driver = Capybara.current_session.driver
    case Capybara.current_driver
    when :selenium
      ShowMeTheCookies::Selenium.new driver
    when :rack_test
      ShowMeTheCookies::RackTest.new driver
    else
      raise "unsupported driver, use rack::test, selenium/webdriver or culerity"
    end
  end
end