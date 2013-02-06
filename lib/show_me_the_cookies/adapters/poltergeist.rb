class ShowMeTheCookies::Poltergeist
  def initialize(driver)
    @browser = driver.browser
  end

  def get_me_the_cookie(name)
    cookie = cookies_hash[name.to_s]
    translate(cookie) unless cookie.nil?
  end

  def get_me_the_cookies
    cookies_hash.values.map(&method(:translate))
  end

  def expire_cookies
    cookies_hash.each do |name, cookie|
      delete_cookie(name) if (cookie.expires rescue nil).nil?
    end
  end

  def delete_cookie(name)
    @browser.remove_cookie(name.to_s)
  end

  private

  def cookies_hash
    @browser.cookies
  end

  def translate(cookie)
    {
      :name => cookie.name,
      :domain => cookie.domain,
      :value => cookie.value,
      :expires => (cookie.expires rescue nil),
      :path => cookie.path,
      :secure => cookie.secure?,
      :httponly => cookie.httponly?
    }
  end
end
