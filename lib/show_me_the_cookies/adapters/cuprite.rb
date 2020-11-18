module ShowMeTheCookies
  class Cuprite
    def initialize(driver)
      @browser = driver.browser
      @driver = driver
    end

    def get_me_the_cookie(name)
      cookie = cookies_hash[name.to_s]
      translate(cookie) unless cookie.nil?
    end

    def get_me_the_cookies
      cookies_hash.map {|name, cookie| translate(cookie) }
    end

    def expire_cookies
      cookies_hash.each do |name, cookie|
        delete_cookie(name) if (cookie.expires rescue nil).nil?
      end
    end

    def delete_cookie(name)
      @driver.remove_cookie(name.to_s)
    end

    def create_cookie(name, value, options)
      # see: https://github.com/rubycdp/cuprite#manipulating-cookies
      @driver.set_cookie(name, value, options)
    end

  private

    def cookies_hash
      @driver.cookies
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
end
