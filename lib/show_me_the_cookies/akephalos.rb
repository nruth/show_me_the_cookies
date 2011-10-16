class ShowMeTheCookies::Akephalos
  def initialize(driver)
    @driver = driver
    @browser = driver.browser
  end

  def get_me_the_cookie(cookie_name)
    cookie = get_me_the_raw_cookie(cookie_name)
    cookie && _translate_cookie(cookie)
  end

  def get_me_the_cookies
    cookies.map {|c| _translate_cookie(c) }
  end

  def delete_cookie(cookie_name)
    cookie = get_me_the_raw_cookie(cookie_name)
    @browser.cookies.delete(cookie) if cookie
  end

  def expire_cookies
    cookies.each do |c|
      # it drops expired cookies for us, so just remove session cookies
      # we don't care that it's a badly decoded java date object, just that it's present
      delete_cookie(c.name)  if c.expires == nil
    end
  end

private
  def get_me_the_raw_cookie(cookie_name)
    @browser.cookies[cookie_name.to_s]
  end

  def cookies
    @browser.cookies.to_a
  end

  def _translate_cookie(cookie)
    c = {:name => cookie.name.to_s, 
        :domain => cookie.domain,
        :value => cookie.value, 
        :expires => cookie.expires,
        :path => cookie.path
    }
    # Akephalos2 returns a java.util.Date or somesuch that looks like this, so we
    # remove it if necessary
    #
    # {:value=>"249920784.1048820629.1318215489.1318215489.1318215489.1",
    #  :path=>"/",
    # :domain=>"gw.lvh.me",
    # :name=>"__utma",
    # :expires=>
    #  #<DRb::DRbUnknown:0x11d7825d0
    #   @buf=
    #    "\004\bU:\031Java::JavaUtil::Date\"3\254?sr\000\016java.util.Datehj\201\001KYt\031\003\000\000xpw\b\000\000\001A\233&\250\200x",
    #   @name="Java::">},
    #
    c[:expires] = nil if c[:expires].class.name == "DRb::DRbUnknown"
    c
  end
end