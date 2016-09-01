# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160901042330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plugin_trackers", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "plugin_id"
    t.string   "current_version"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["plugin_id"], name: "index_plugin_trackers_on_plugin_id", using: :btree
    t.index ["site_id"], name: "index_plugin_trackers_on_site_id", using: :btree
  end

  create_table "plugins", force: :cascade do |t|
    t.string   "name"
    t.string   "lastest_version"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
