class ShowMeTheCookies::Webkit
  def initialize(driver)
    @browser = driver.browser
    @driver = driver
  end

  def get_me_the_cookie(name)
    cookie = cookie_jar.find(name)
    translate(cookie) unless cookie.nil?
  end

  def get_me_the_cookies
    cookies.each.map(&method(:translate))
  end

  def expire_cookies
    cookies.each do |cookie|
      delete_cookie(cookie.name) if cookie.expires.nil?
    end
  end

  # Since QTWebkit doesn't seem to offer deletion, clearing all and re-setting the rest seems to be it
  def delete_cookie(name)
    old_cookies = cookies
    @browser.clear_cookies
    old_cookies.each do |cookie|
      @browser.set_cookie(cookie) unless cookie.name == name.to_s
    end
  end

  def create_cookie(name, value, options)
    puts "Webkit create_cookie options not supported: #{options.inspect}" if options && (options != {})
    host = Capybara.app_host ? URI(Capybara.app_host).host : '127.0.0.1'
    @browser.set_cookie("#{name}=#{value}; domain=#{host}")
  end

  private

  # see https://github.com/thoughtbot/capybara-webkit/blob/master/lib/capybara/webkit/cookie_jar.rb
  def cookie_jar
    @driver.cookies
  end

  def cookies
    @browser.get_cookies.map { |c| WEBrick::Cookie.parse_set_cookie(c) }
  end

  def translate(cookie)
    {
      :name => cookie.name,
      :domain => cookie.domain,
      :value => cookie.value,
      :expires => (cookie.expires rescue nil),
      :path => cookie.path,
      :secure => cookie.secure
    }
  end
end
