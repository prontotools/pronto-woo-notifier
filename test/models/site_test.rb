require 'test_helper'

class SiteTest < ActiveSupport::TestCase
    def setup
        @site = Site.new(name: "PClantech",
                        domain: "http://www.pclantech.com",
                        port: "1000")
    end

    test "name should be present" do
        @site.name = ""
        assert_not @site.valid?
    end

    test "domain should be present" do
        @site.domain = ""
        assert_not @site.valid?
    end

    test "port should be present" do
        @site.port = ""
        assert_not @site.valid?
    end

    test "database name should be present" do
        @site.database_name = ""
        assert_not @site.valid?
    end

    test "port should be unique" do
        @duplicate_site = Site.new(
            name: "ELG",
            domain: "http://www.elg.com",
            port: "1000"
        )
        @site.save
        assert_not @duplicate_site.save
        assert_equal @duplicate_site.errors.full_messages, ["Port has already been taken"]
    end

    test "domain should be url format" do
        @site.domain = "www.24"
        assert_not @site.save
        assert_equal @site.errors.full_messages, ["Domain is invalid"]
    end

end
