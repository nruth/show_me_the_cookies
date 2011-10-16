class ShowMeTheCookies::RackTest
  def initialize(rack_test_driver)
    @rack_test_driver = rack_test_driver
  end

  def get_me_the_cookie(cookie_name)
    _translate_cookie cookies.select {|c| c.name == cookie_name}.first
  end

  def get_me_the_cookies
    cookies.map {|c| _translate_cookie(c) }
  end

  def expire_cookies
    cookies.reject! do |existing_cookie|
      # See http://j-ferguson.com/testing/bdd/hacking-capybara-cookies/
      # catch session cookies/no expiry (nil) and past expiry (true)
      existing_cookie.expired? != false
    end    
  end

  def delete_cookie(cookie_name)
    cookies.reject! do |existing_cookie|
      existing_cookie.name.downcase == cookie_name
    end
  end

private
  def cookie_jar
    @rack_test_driver.browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
  end

  def cookies
    cookie_jar.instance_variable_get(:@cookies)
  end

  def _translate_cookie(cookie)
    {:name => cookie.name, 
    :domain => cookie.domain,
    :value => cookie.value, 
    :expires => cookie.expires,
    :path => cookie.path}
  end
end