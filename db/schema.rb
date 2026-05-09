# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_07_032632) do
  create_table "addresses", force: :cascade do |t|
    t.string "city"
    t.datetime "created_at", null: false
    t.string "state"
    t.string "street_address"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "zip_code"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "booking_status"
    t.datetime "created_at", null: false
    t.integer "job_request_id", null: false
    t.datetime "scheduled_at"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["job_request_id"], name: "index_bookings_on_job_request_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "job_requests", force: :cascade do |t|
    t.integer "address_id"
    t.datetime "created_at", null: false
    t.integer "customer_id"
    t.text "job_description"
    t.integer "job_status"
    t.string "job_title"
    t.integer "provider_id"
    t.integer "service_category_id"
    t.datetime "updated_at", null: false
  end

  create_table "provider_services", force: :cascade do |t|
    t.decimal "base_price"
    t.datetime "created_at", null: false
    t.integer "provider_id", null: false
    t.integer "service_category_id", null: false
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_provider_services_on_provider_id"
    t.index ["service_category_id"], name: "index_provider_services_on_service_category_id"
  end

  create_table "service_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.string "username"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "bookings", "job_requests"
  add_foreign_key "bookings", "users"
  add_foreign_key "provider_services", "users", column: "provider_id"
  add_foreign_key "provider_services", "service_categories"
end
