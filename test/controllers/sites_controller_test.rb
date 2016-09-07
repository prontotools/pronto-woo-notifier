require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = sites(:one)
  end

  test "should get index" do
    get sites_url
    assert_response :success
  end

  test "should get new" do
    get new_site_url
    assert_response :success
  end

  test "should create site" do
    assert_difference('Site.count') do
      post sites_url, params: { site: { domain: "http://www.elg.com", name: "ELG", port: 8888 } }
    end

    assert_redirected_to site_url(Site.last)
  end

  test "should show site" do
    get site_url(@site)
    assert_response :success
  end

  test "should get edit" do
    get edit_site_url(@site)
    assert_response :success
  end

  test "should update site" do
    patch site_url(@site), params: { site: { domain: @site.domain, name: @site.name, port: @site.port } }
    assert_redirected_to site_url(@site)
  end

  test "should destroy site" do
    assert_difference('Site.count', -1) do
      delete site_url(@site)
    end

    assert_redirected_to sites_url
  end

  test "should create new plugin tracker when that site no that plugin(sync_all)" do
    url = "http://www.pclantech.com/api/pronto/get_active_woocommerce_plugins_and_version/"
    body_response = {
        "status": "ok", "plugins": {"WooCommerce": "4.4.14"}
    }.to_json
    stub_request(:get, url).to_return(
      :status => 200, :body => body_response, :headers => {
        'Content-Type' => 'application/json'
      }
    )

    assert_difference "Site.first.plugins.count" do
      get sites_sync_url
    end

    plugin_tracker = Site.first.plugin_trackers.first
    assert_equal plugin_tracker.current_version, "4.4.14"

    plugin = plugin_tracker.plugin
    assert_equal plugin.name , "WooCommerce"
    assert_equal plugin.latest_version , "1.0.0"

    assert_redirected_to sites_url
  end

  test "should update plugin tracker when that site has that plugin(sync_all)" do
    url = "http://www.pclantech.com/api/pronto/get_active_woocommerce_plugins_and_version/"
    body_response = {
        "status": "ok", "plugins": {"WooCommerce": "4.4.14"}
    }.to_json
    stub_request(:get, url).to_return(
      :status => 200, :body => body_response, :headers => {
        'Content-Type' => 'application/json'
      }
    )

    site = Site.first
    plugin = Plugin.find_by(name: "WooCommerce")
    site.plugin_trackers.create(plugin: plugin, current_version: "0.0.0")

    assert_no_difference "Site.first.plugins.count" do
      get sites_sync_url
    end

    plugin_tracker = Site.first.plugin_trackers.first
    assert_equal plugin_tracker.current_version, "4.4.14"

    plugin = plugin_tracker.plugin
    assert_equal plugin.name , "WooCommerce"
    assert_equal plugin.latest_version , "1.0.0"

    assert_redirected_to sites_url
  end

  test "should redirect ro sites url when error(sync_all)" do
    url = "http://www.pclantech.com/api/pronto/get_active_woocommerce_plugins_and_version/"
    body_response = {
        "status": "error"
    }.to_json
    stub_request(:get, url).to_return(
      :status => 5000, :body => body_response, :headers => {
        'Content-Type' => 'application/json'
      }
    )

    assert_no_difference "Site.first.plugins.count" do
      get sites_sync_url
    end

    assert_redirected_to sites_url
  end


  test "should create new plugin tracker when that site no that plugin(sync each)" do
    url = "http://www.pclantech.com/api/pronto/get_active_woocommerce_plugins_and_version/"
    body_response = {
        "status": "ok", "plugins": {"WooCommerce": "4.4.14"}
    }.to_json
    stub_request(:get, url).to_return(
      :status => 200, :body => body_response, :headers => {
        'Content-Type' => 'application/json'
      }
    )

    assert_difference "Site.first.plugins.count" do
      get site_sync_url(@site)
    end

    plugin_tracker = Site.first.plugin_trackers.first
    assert_equal plugin_tracker.current_version, "4.4.14"

    plugin = plugin_tracker.plugin
    assert_equal plugin.name , "WooCommerce"
    assert_equal plugin.latest_version , "1.0.0"

    assert_redirected_to site_url(@site)
  end

  test "should update plugin tracker when that site has that plugin(sync_each)" do
    url = "http://www.pclantech.com/api/pronto/get_active_woocommerce_plugins_and_version/"
    body_response = {
        "status": "ok", "plugins": {"WooCommerce": "4.4.14"}
    }.to_json
    stub_request(:get, url).to_return(
      :status => 200, :body => body_response, :headers => {
        'Content-Type' => 'application/json'
      }
    )

    site = Site.first
    plugin = Plugin.find_by(name: "WooCommerce")
    site.plugin_trackers.create(plugin: plugin, current_version: "0.0.0")

    assert_no_difference "Site.first.plugins.count" do
      get site_sync_url(@site)
    end

    plugin_tracker = Site.first.plugin_trackers.first
    assert_equal plugin_tracker.current_version, "4.4.14"

    plugin = plugin_tracker.plugin
    assert_equal plugin.name , "WooCommerce"
    assert_equal plugin.latest_version , "1.0.0"

    assert_redirected_to site_url(@site)
  end

  test "should redirect ro sites url when error(sync_each)" do
    url = "http://www.pclantech.com/api/pronto/get_active_woocommerce_plugins_and_version/"
    body_response = {
        "status": "error"
    }.to_json
    stub_request(:get, url).to_return(
      :status => 5000, :body => body_response, :headers => {
        'Content-Type' => 'application/json'
      }
    )

    assert_no_difference "Site.first.plugins.count" do
      get site_sync_url(@site)
    end

    assert_redirected_to site_url(@site)
  end


end
