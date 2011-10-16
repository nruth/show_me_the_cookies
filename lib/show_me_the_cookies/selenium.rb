class ShowMeTheCookies::Selenium
  def initialize(driver)
    @browser = driver.browser
    self
  end

  def get_me_the_cookie(cookie_name)
    @browser.manage.cookie_named(cookie_name)
  end

  def get_me_the_cookies
    @browser.manage.all_cookies
  end

  def expire_cookies
    # we don't need to catch the expired cookies here, the browser will do it for us (duh!)
    cookies_to_delete = @browser.manage.all_cookies.each do |c|
      @browser.manage.delete_cookie(c[:name]) if c[:expires] == nil
    end
  end

  def delete_cookie(cookie_name)
    @browser.manage.delete_cookie(cookie_name)
  end
end