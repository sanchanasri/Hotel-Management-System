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

ActiveRecord::Schema[7.0].define(version: 2024_02_15_151557) do
  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.text "location"
    t.string "contact_no"
    t.json "days"
    t.json "times"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "hotel_id", null: false
    t.string "name"
    t.json "days"
    t.json "times"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "average_rating"
    t.index ["hotel_id"], name: "index_items_on_hotel_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "hotel_id", null: false
    t.integer "item_id", null: false
    t.integer "value"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_ratings_on_hotel_id"
    t.index ["item_id"], name: "index_ratings_on_item_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "hotels"
  add_foreign_key "ratings", "hotels"
  add_foreign_key "ratings", "items"
  add_foreign_key "ratings", "users"
end
