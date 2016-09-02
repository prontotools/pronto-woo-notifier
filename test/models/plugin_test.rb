require 'test_helper'

class PluginTest < ActiveSupport::TestCase
    def setup
        @plugin = Plugin.new(name: "Woo Commerce", latest_version: "1.0.0")
    end

    test "name should be present" do
        @plugin.name = ""
        assert_not @plugin.valid?
    end

    test "latest_version should be valid" do
        @plugin.latest_version = ""
        assert_not @plugin.valid?
    end
end
