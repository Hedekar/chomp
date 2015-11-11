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

ActiveRecord::Schema.define(version: 20151109044426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.float    "serving"
    t.integer  "category"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "foods", ["user_id"], name: "index_foods_on_user_id", using: :btree

  create_table "nutrients", force: :cascade do |t|
    t.integer  "ref_id"
    t.string   "name"
    t.string   "group"
    t.string   "unit"
    t.float    "value"
    t.integer  "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "nutrients", ["food_id"], name: "index_nutrients_on_food_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "gender"
    t.date     "birth"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "weights", force: :cascade do |t|
    t.integer  "Weight"
    t.string   "Units"
    t.datetime "Date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "weights", ["user_id", "created_at"], name: "index_weights_on_user_id_and_created_at", using: :btree
  add_index "weights", ["user_id"], name: "index_weights_on_user_id", using: :btree

  create_table "welcomes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "foods", "users"
  add_foreign_key "nutrients", "foods"
  add_foreign_key "weights", "users"
end
