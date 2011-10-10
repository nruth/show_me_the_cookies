class ShowMeTheCookies::Akephalos
  def initialize(driver)
    @driver = driver
    @browser = driver.browser
  end

  def show_me_the_cookie(cookie_name)
    cookie = @browser.cookies[cookie_name.to_s]
    cookie && _translate_cookie(cookie)
  end

  def show_me_the_cookies
    get_me_the_cookies.inspect
  end

  def cookie_names
    document_cookie = @driver.evaluate_script("document.cookie")
    pairs = document_cookie && document_cookie.split(/ *; */)
    pairs.map { |pair| pair.split(/\=/)[0].strip }
  end

  def get_me_the_cookies
    # Akephalos 2's browser.cookies.each doesn't appear to work well, so
    # we use Javascript to get the document.cookie string, which is a poort
    # substitute (cf. HTTP only cookies), but it's better than nothing.
    #
    cookie_names.map { |name| show_me_the_cookie(name) }
  end

  def delete_cookie(cookie_name)
    cookie = show_me_the_cookie(cookie_name)
    @browser.cookies.delete(cookie) if cookie
  end

  private

  def _translate_cookie(cookie)
    c = {:name => cookie.name.to_s, 
        :domain => cookie.domain,
        :value => cookie.value, 
        :expires => cookie.expires,
        :path => cookie.path}
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