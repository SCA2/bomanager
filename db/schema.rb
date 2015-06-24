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

ActiveRecord::Schema.define(version: 20150620055147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bom_items", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bom_id"
    t.integer  "component_id"
  end

  add_index "bom_items", ["bom_id"], name: "index_bom_items_on_bom_id", using: :btree
  add_index "bom_items", ["component_id"], name: "index_bom_items_on_component_id", using: :btree

  create_table "boms", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "user_id"
  end

  add_index "boms", ["user_id"], name: "index_boms_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "components", force: :cascade do |t|
    t.string  "name"
    t.integer "category_id"
    t.string  "manufacturer"
    t.text    "description"
    t.string  "image_url"
  end

  add_index "components", ["category_id"], name: "index_components_on_category_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string  "name"
    t.string  "value"
    t.integer "component_id"
  end

  add_index "properties", ["component_id"], name: "index_properties_on_component_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
