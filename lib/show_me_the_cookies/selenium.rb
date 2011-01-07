class ShowMeTheCookies::Selenium
  def initialize(browser)
    @browser = browser
    self
  end
  
  def show_me_the_cookies
    @browser.manage.all_cookies.map(&:inspect).join("\n")
  end
  
  def delete_cookie(cookie_name)
    @browser.manage.delete_cookie(cookie_name)
  end
end