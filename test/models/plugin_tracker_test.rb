require 'test_helper'

class PluginTrackerTest < ActiveSupport::TestCase
    def setup
        @site = Site.first
        @plugin = Plugin.first
        @plugin_tracker = PluginTracker.new(site: @site,
                                            plugin: @plugin,
                                            current_version: "1.0.0")
    end

    test "site should be present" do
        @plugin_tracker.site = nil
        assert_not @plugin_tracker.valid?
    end

    test "plugin should be present" do
        @plugin_tracker.plugin = nil
        assert_not @plugin_tracker.valid?
    end

    test "current_version should be present" do
        @plugin_tracker.current_version = nil
        assert_not @plugin_tracker.valid?
    end

end
