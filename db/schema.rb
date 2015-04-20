# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150420000933) do

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.integer  "org_id"
    t.string   "phone"
    t.string   "email"
    t.string   "timezone"
    t.decimal  "latitude",              precision: 9, scale: 6
    t.decimal  "longitude",             precision: 9, scale: 6
    t.string   "street_address1"
    t.string   "street_address2"
    t.string   "city"
    t.string   "state_province_region"
    t.string   "zip_postal_code"
    t.string   "country_code"
    t.integer  "sunday_opening"
    t.integer  "sunday_closing"
    t.integer  "monday_opening"
    t.integer  "monday_closing"
    t.integer  "tuesday_opening"
    t.integer  "tuesday_closing"
    t.integer  "wednesday_opening"
    t.integer  "wednesday_closing"
    t.integer  "thursday_opening"
    t.integer  "thursday_closing"
    t.integer  "friday_opening"
    t.integer  "friday_closing"
    t.integer  "saturday_opening"
    t.integer  "saturday_closing"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "locations", ["city"], name: "index_locations_on_city"
  add_index "locations", ["country_code"], name: "index_locations_on_country_code"
  add_index "locations", ["friday_closing"], name: "index_locations_on_friday_closing"
  add_index "locations", ["friday_opening"], name: "index_locations_on_friday_opening"
  add_index "locations", ["latitude"], name: "index_locations_on_latitude"
  add_index "locations", ["longitude"], name: "index_locations_on_longitude"
  add_index "locations", ["monday_closing"], name: "index_locations_on_monday_closing"
  add_index "locations", ["monday_opening"], name: "index_locations_on_monday_opening"
  add_index "locations", ["org_id"], name: "index_locations_on_org_id"
  add_index "locations", ["permalink"], name: "index_locations_on_permalink"
  add_index "locations", ["saturday_closing"], name: "index_locations_on_saturday_closing"
  add_index "locations", ["saturday_opening"], name: "index_locations_on_saturday_opening"
  add_index "locations", ["state_province_region"], name: "index_locations_on_state_province_region"
  add_index "locations", ["sunday_closing"], name: "index_locations_on_sunday_closing"
  add_index "locations", ["sunday_opening"], name: "index_locations_on_sunday_opening"
  add_index "locations", ["thursday_closing"], name: "index_locations_on_thursday_closing"
  add_index "locations", ["thursday_opening"], name: "index_locations_on_thursday_opening"
  add_index "locations", ["tuesday_closing"], name: "index_locations_on_tuesday_closing"
  add_index "locations", ["tuesday_opening"], name: "index_locations_on_tuesday_opening"
  add_index "locations", ["wednesday_closing"], name: "index_locations_on_wednesday_closing"
  add_index "locations", ["wednesday_opening"], name: "index_locations_on_wednesday_opening"

  create_table "memberships", force: :cascade do |t|
    t.integer  "org_id"
    t.integer  "location_id"
    t.integer  "user_id"
    t.string   "privileges"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "memberships", ["location_id", "user_id", "privileges"], name: "index_memberships_on_location_id_and_user_id_and_privileges"
  add_index "memberships", ["location_id"], name: "index_memberships_on_location_id"
  add_index "memberships", ["org_id", "user_id", "privileges"], name: "index_memberships_on_org_id_and_user_id_and_privileges"
  add_index "memberships", ["org_id"], name: "index_memberships_on_org_id"
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "orgs", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.string   "email"
    t.string   "phone"
    t.string   "url"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orgs", ["owner_id"], name: "index_orgs_on_owner_id"
  add_index "orgs", ["permalink"], name: "index_orgs_on_permalink"

  create_table "reservations", force: :cascade do |t|
    t.integer  "space_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "zipcode"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "confirmation"
    t.integer  "price_in_cents"
    t.string   "chargeid"
    t.datetime "checked_in_at"
    t.datetime "canceled_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "reservations", ["canceled_at"], name: "index_reservations_on_canceled_at"
  add_index "reservations", ["chargeid"], name: "index_reservations_on_chargeid"
  add_index "reservations", ["checked_in_at"], name: "index_reservations_on_checked_in_at"
  add_index "reservations", ["confirmation"], name: "index_reservations_on_confirmation"
  add_index "reservations", ["email"], name: "index_reservations_on_email"
  add_index "reservations", ["ends_at"], name: "index_reservations_on_ends_at"
  add_index "reservations", ["price_in_cents"], name: "index_reservations_on_price_in_cents"
  add_index "reservations", ["space_id", "starts_at", "ends_at"], name: "index_reservations_on_space_id_and_starts_at_and_ends_at"
  add_index "reservations", ["space_id"], name: "index_reservations_on_space_id"
  add_index "reservations", ["starts_at"], name: "index_reservations_on_starts_at"
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id"

  create_table "settings", force: :cascade do |t|
    t.integer  "org_id"
    t.string   "stripe_publishable_key"
    t.string   "stripe_secret_key_encrypted"
    t.string   "salt"
    t.text     "default_location_spaces"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "settings", ["org_id"], name: "index_settings_on_org_id"

  create_table "slides", force: :cascade do |t|
    t.integer  "slideshowable_id"
    t.string   "slideshowable_type"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "order"
    t.string   "caption"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "slides", ["order"], name: "index_slides_on_order"
  add_index "slides", ["slideshowable_id", "slideshowable_type", "order"], name: "index_slides_on_slideshowable_and_order"
  add_index "slides", ["slideshowable_id", "slideshowable_type"], name: "index_slides_on_slideshowable"
  add_index "slides", ["slideshowable_id"], name: "index_slides_on_slideshowable_id"

  create_table "spaces", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "name"
    t.string   "permalink"
    t.integer  "standard_hourly_price_in_cents"
    t.string   "picurl"
    t.integer  "reservable_quantity"
    t.text     "description"
    t.integer  "max_days_in_advance_reservable"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "spaces", ["location_id", "permalink"], name: "index_spaces_on_location_id_and_permalink"
  add_index "spaces", ["location_id"], name: "index_spaces_on_location_id"
  add_index "spaces", ["permalink"], name: "index_spaces_on_permalink"
  add_index "spaces", ["reservable_quantity"], name: "index_spaces_on_reservable_quantity"
  add_index "spaces", ["standard_hourly_price_in_cents"], name: "index_spaces_on_standard_hourly_price_in_cents"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "zipcode"
    t.string   "angellistid"
    t.string   "facebookid"
    t.string   "githubid"
    t.string   "googleid"
    t.string   "linkedinid"
    t.string   "twitterid"
    t.string   "picurl"
    t.boolean  "superuser"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["angellistid"], name: "index_users_on_angellistid"
  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["facebookid"], name: "index_users_on_facebookid"
  add_index "users", ["githubid"], name: "index_users_on_githubid"
  add_index "users", ["googleid"], name: "index_users_on_googleid"
  add_index "users", ["linkedinid"], name: "index_users_on_linkedinid"
  add_index "users", ["superuser"], name: "index_users_on_superuser"
  add_index "users", ["twitterid"], name: "index_users_on_twitterid"
  add_index "users", ["username"], name: "index_users_on_username"

end
