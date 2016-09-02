require 'test_helper'

class PluginsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plugin = plugins(:one)
  end

  test "should get index" do
    get plugins_url
    assert_response :success
  end

  test "should get new" do
    get new_plugin_url
    assert_response :success
  end

  test "should create plugin" do
    assert_difference('Plugin.count') do
      post plugins_url, params: { plugin: { latest_version: @plugin.latest_version, name: @plugin.name } }
    end

    assert_redirected_to plugin_url(Plugin.last)
  end

  test "should show plugin" do
    get plugin_url(@plugin)
    assert_response :success
  end

  test "should get edit" do
    get edit_plugin_url(@plugin)
    assert_response :success
  end

  test "should update plugin" do
    patch plugin_url(@plugin), params: { plugin: { latest_version: @plugin.latest_version, name: @plugin.name } }
    assert_redirected_to plugin_url(@plugin)
  end

  test "should destroy plugin" do
    assert_difference('Plugin.count', -1) do
      delete plugin_url(@plugin)
    end

    assert_redirected_to plugins_url
  end
end
