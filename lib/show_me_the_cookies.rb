module ShowMeTheCookies
  require 'show_me_the_cookies/adapters/rack_test'
  require 'show_me_the_cookies/adapters/poltergeist'
  require 'show_me_the_cookies/adapters/selenium'

  @adapters = {}
  class << self
    attr_reader :adapters
    
    # Register your own capybara-driver cookie adapter. 
    # Use the same name as the one Capybara does to identify that driver.
    # Implement the interface of spec/shared_examples_for_api, as seen in lib/show_me_the_cookies/drivers
    def register_adapter(driver, adapter)
      adapters[driver] = adapter
    end
  end

  # to register your own adapter/driver do this in your test setup code somewhere e.g. spec/support
  register_adapter(:selenium, ShowMeTheCookies::Selenium)
  register_adapter(:rack_test, ShowMeTheCookies::RackTest)
  register_adapter(:poltergeist, ShowMeTheCookies::Poltergeist)

  # puts a string summary of the cookie
  def show_me_the_cookie(cookie_name)
    puts "#{cookie_name}: #{get_me_the_cookie(cookie_name).inspect}"
  end
  
  # returns a hash of the cookie
  # form: {:name, :domain, :value, :expires, :path}
  def get_me_the_cookie(cookie_name)
    current_driver_adapter.get_me_the_cookie(cookie_name)
  end

  # puts a string summary of all cookies
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
  def current_driver_adapter
    adapter = ShowMeTheCookies.adapters[Capybara.current_driver]
    if adapter.nil?
      if driver_uses_selenium? # to support custom selenium drivers / configs (whatever they are?)
        adapter = adapters[:selenium]
      else
        raise("Unsupported driver #{Capybara.current_driver}, use one of #{adapters.keys}")
      end
    end
    adapter.new(Capybara.current_session.driver)
  end

  def driver_uses_selenium?
    driver = Capybara.drivers[Capybara.current_driver].call(nil)
    driver.is_a?(Capybara::Selenium::Driver)
  end
end
