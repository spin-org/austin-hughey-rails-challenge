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

ActiveRecord::Schema.define(version: 2019_06_15_002443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "address_standardizer"
  enable_extension "fuzzystrmatch"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_sfcgal"
  enable_extension "postgis_tiger_geocoder"
  enable_extension "postgis_topology"
  enable_extension "uuid-ossp"

  create_table "reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "scooter_id"
    t.float "battery_level"
    t.geometry "location", limit: {:srid=>0, :type=>"st_point"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battery_level"], name: "index_reports_on_battery_level"
    t.index ["location"], name: "index_reports_on_location", using: :gist
    t.index ["scooter_id"], name: "index_reports_on_scooter_id"
  end

  create_table "scooters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_scooters_on_active"
  end

  create_table "tickets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "scooter_id"
    t.string "opened_by"
    t.boolean "deactivate_scooter"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deactivate_scooter"], name: "index_tickets_on_deactivate_scooter"
    t.index ["opened_by"], name: "index_tickets_on_opened_by"
  end

  add_foreign_key "reports", "scooters"
  add_foreign_key "tickets", "scooters"
end
