require 'test_helper'

class PluginTest < ActiveSupport::TestCase
    def setup
        @plugin = Plugin.new(name: "Woo Commerce", lastest_version: "1.0.0")
    end

    test "name should be present" do
        @plugin.name = ""
        assert_not @plugin.valid?
    end

    test "lastest_version should be valid" do
        @plugin.lastest_version = ""
        assert_not @plugin.valid?
    end
end
