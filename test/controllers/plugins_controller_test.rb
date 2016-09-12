require 'test_helper'

class PluginsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plugin = plugins(:one)
  end

  test "should get index" do
    get plugins_url
    assert_response :success
  end

  test "should sync plugin" do
      url = "http://prontotools.pi.bypronto.com/api/pronto/get_all_woocommerce_plugins_and_latest_version/"
      body_response = {"status": "ok", "plugins": {"woocommerce-follow-up-emails": "4.4.14"}}.to_json
      stub_request(:get, url).to_return(:status => 200, :body => body_response, :headers => {'Content-Type' => 'application/json'})

      assert_difference "Plugin.count" do
        get plugins_sync_url
      end

      plugin = Plugin.find_by(name: "woocommerce-follow-up-emails")
      assert_equal plugin.latest_version, "4.4.14"
      assert_redirected_to plugins_url
  end

  test "should update plugin version if already exist" do
      url = "http://prontotools.pi.bypronto.com/api/pronto/get_all_woocommerce_plugins_and_latest_version/"
      body_response = {
          "status": "ok", "plugins": {"WooCommerce": "4.4.14"}
      }.to_json
      stub_request(:get, url).to_return(
        :status => 200, :body => body_response, :headers => {
          'Content-Type' => 'application/json'
        }
      )

      assert_no_difference "Plugin.count" do
        get plugins_sync_url
      end

      plugin = Plugin.find_by(name: "WooCommerce")
      assert_equal "4.4.14", plugin.latest_version
      assert_redirected_to plugins_url
  end

  test "should redirect to plugins url when got error" do
      url = "http://prontotools.pi.bypronto.com/api/pronto/get_all_woocommerce_plugins_and_latest_version/"
      body_response = {
          "status": "error",
      }.to_json
      stub_request(:get, url).to_return(
        :status => 500, :body => body_response, :headers => {
          'Content-Type' => 'application/json'
        }
      )

      assert_no_difference "Plugin.count" do
        get plugins_sync_url
      end
      assert_redirected_to plugins_url
  end

end
