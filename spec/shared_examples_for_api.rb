shared_examples "the API" do
  def cookies_should_contain(key, value)
    key_present = inspect_cookies =~ /#{key}/
    value_present = inspect_cookies =~ /#{value}/
    (key_present and value_present).should be_true
  end

  def cookies_should_not_contain(key, value)
    key_present = inspect_cookies =~ /#{key}/
    value_present = inspect_cookies =~ /#{value}/
    (key_present and value_present).should be_false
  end

  describe "show_me_the_cookie" do
    it "returns the cookie value" do
      visit '/set/foo/bar'
      show_me_the_cookie('foo').should == "bar"
    end
  end

  describe "inspect_cookies" do
    it "returns a driver-dependent string summary of the session cookie's k/v pairs" do
      visit '/set/foo/bar'
      page.should have_content("Setting foo=bar")
      cookies_should_contain('foo', 'bar')

      visit '/set/myopic/mice'
      page.should have_content("Setting myopic=mice")
      cookies_should_contain('myopic','mice')
    end
  end

  describe "delete_cookie(cookie_name)" do
    it "deletes a k/v pair from the session cookie" do
      visit '/set/choc/milk'
      visit '/set/extras/hazlenut'
      cookies_should_contain('extras', 'hazlenut')
      cookies_should_contain('choc', 'milk')

      visit '/delete/choc'
      page.should have_content("Deleting choc")
      cookies_should_contain('extras', 'hazlenut')
      cookies_should_not_contain('choc', 'milk')
    end
  end

  describe "expire_cookies" do
    it "removes cookies without expiry times set" do
      visit '/set/choc/milk'
      visit '/set/extras/hazlenut'
      visit '/set/myopic/mice'
      cookies_should_contain('choc', 'milk')
      cookies_should_contain('extras', 'hazlenut')
      cookies_should_contain('myopic','mice')

      expire_cookies
      cookies_should_not_contain('choc', 'milk')
      cookies_should_not_contain('extras', 'hazlenut')
      cookies_should_not_contain('myopic','mice')
    end

    it "removes cookies which are past their expiry time" do
      visit '/set_stale/rotting/fruit'
      visit '/set_persistent/fresh/vegetables'

      expire_cookies
      cookies_should_not_contain('rotting','fruit')
      cookies_should_contain('fresh','vegetables')
    end
  end
end