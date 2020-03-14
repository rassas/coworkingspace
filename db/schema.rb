# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_14_201715) do

  create_table "coworking_spaces", force: :cascade do |t|
    t.string "name"
    t.integer "workstations_limit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "biography"
    t.integer "status"
    t.datetime "confirmed_at"
    t.integer "coworking_space_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coworking_space_id"], name: "index_requests_on_coworking_space_id"
  end

  add_foreign_key "requests", "coworking_spaces"
end
