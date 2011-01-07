class ShowMeTheCookies::Culerity
  def initialize(browser)
    @browser = browser
  end

  def show_me_the_cookies
    @browser.cookies.send_remote(:inspect)
  end

  def delete_cookie(cookie_name)
    @browser.remove_cookie('localhost', cookie_name)
  end
end