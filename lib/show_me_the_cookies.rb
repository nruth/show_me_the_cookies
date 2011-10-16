module ShowMeTheCookies
  require 'show_me_the_cookies/rack_test'
  require 'show_me_the_cookies/selenium'
  require 'show_me_the_cookies/akephalos'

  # return a string summary of the cookie
  def show_me_the_cookie(cookie_name)
    puts "#{cookie_name}: #{get_me_the_cookie(cookie_name).inspect}"
  end
  
  # returns a hash of the cookie
  # form: {:name, :domain, :value, :expires, :path}
  def get_me_the_cookie(cookie_name)
    current_driver_adapter.get_me_the_cookie(cookie_name)
  end

  # return a string summary of all cookies
  def show_me_the_cookies
    puts "Cookies: #{get_me_the_cookies.inspect}"
  end
  
  # returns an array of cookie hashes
  # form: [{:name, :domain, :value, :expires, :path}]
  def get_me_the_cookies
    current_driver_adapter.get_me_the_cookies
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
      :rack_test  => ShowMeTheCookies::RackTest,
      :akephalos  => ShowMeTheCookies::Akephalos
    }
  end

  def current_driver_adapter
    adapter = adapters[Capybara.current_driver] || raise("Unsupported driver #{driver}, use one of #{drivers.keys}")
    adapter.new(Capybara.current_session.driver)
  end
end