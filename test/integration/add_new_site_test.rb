require 'test_helper'

class AddNewSiteTest < ActionDispatch::IntegrationTest
  test "invalid add site information" do
      get new_site_path
      assert_no_difference "Site.count" do
        post sites_path, params:{ site: { name: "",
                                          domain: "",
                                          port: "100"}}
      end
      assert_select "div#error_explanation"
  end

  test "valid add site inforamtion" do
      get new_site_path
      assert_difference "Site.count", 1 do
        post sites_path, params:{ site: { name: "PClantech",
                                          domain: "http://www.pclantech.com",
                                          port: "100",
                                          database_name: "database"}}
      end
  end

end
