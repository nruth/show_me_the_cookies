shared_examples "The API" do
  describe "API" do
    describe "inspect_cookies" do
      it "returns a driver-dependent string summary of the session cookie's k/v pairs" do
        visit '/set/foo/bar'
        page.should have_content("Setting foo=bar")
        inspect_cookies.should match /foo=bar/
        visit '/set/myopic/mice'
        page.should have_content("Setting myopic=mice")
        inspect_cookies.should match /myopic=mice/
      end
    end

    describe "delete_cookie(cookie_name)" do
      it "deletes a k/v pair from the session cookie" do
        visit '/set/choc/milk'
        visit '/set/extras/hazlenut'
        inspect_cookies.should match /extras=hazlenut/
        inspect_cookies.should match /choc=milk/
        visit '/delete/choc'
        page.should have_content("Deleting choc")
        inspect_cookies.should match /extras=hazlenut/
        inspect_cookies.should_not match /choc=milk/
      end
    end

    describe "expire_cookies" do
      it "removes cookies without expiry times set" do
        visit '/set/choc/milk'; inspect_cookies.should match /choc=milk/
        visit '/set/extras/hazlenut'; inspect_cookies.should match /extras=hazlenut/
        visit '/set/myopic/mice'; inspect_cookies.should match /myopic=mice/
        expire_cookies
        inspect_cookies.should_not match /choc=milk/
        inspect_cookies.should_not match /extras=hazlenut/
        inspect_cookies.should_not match /myopic=mice/
      end

      it "removes cookies which are past their expiry time" do
        visit '/set_stale/rotting/fruit'; inspect_cookies.should match /rotting=fruit/
        visit '/set_persistent/fresh/vegetables'; inspect_cookies.should match /fresh=vegetables/
        expire_cookies
        inspect_cookies.should_not match /rotting=fruit/
        inspect_cookies.should match /fresh=vegetables/
      end
    end
  end
end