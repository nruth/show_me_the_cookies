module ShowMeTheCookies
  require 'show_me_the_cookies/rack_test'
  require 'show_me_the_cookies/selenium'

  # return a string summary of all cookies
  def inspect_cookies
    current_driver_adapter.show_me_the_cookies
  end

  def show_me_the_cookie(cookie_name)
    current_driver_adapter.show_me_the_cookie(cookie_name)
  end

  def show_me_the_cookies
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
  def adapters
    @@drivers ||= {
      :selenium   => ShowMeTheCookies::Selenium,
      :rack_test  => ShowMeTheCookies::RackTest
    }
  end

  def current_driver_adapter
    adapter = adapters[Capybara.current_driver] || raise("Unsupported driver #{driver}, use one of #{drivers.keys}")
    adapter.new(Capybara.current_session.driver)
  end
end