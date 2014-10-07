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

ActiveRecord::Schema.define(version: 20141006220803) do

  create_table "addresses", force: true do |t|
    t.string   "receiver"
    t.string   "name"
    t.string   "post_code"
    t.integer  "area_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faq_sections", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", force: true do |t|
    t.integer  "faq_section_id"
    t.string   "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "information_page_contents", force: true do |t|
    t.integer  "information_page_id"
    t.string   "title"
    t.string   "subtitle"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "information_pages", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "information_pages", ["slug"], name: "index_information_pages_on_slug", unique: true, using: :btree

  create_table "storage_items", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",              precision: 10, scale: 0
    t.decimal  "width",              precision: 10, scale: 0
    t.decimal  "height",             precision: 10, scale: 0
    t.decimal  "depth",              precision: 10, scale: 0
    t.string   "dimensions_measure"
    t.decimal  "capacity",           precision: 10, scale: 0
    t.string   "capacity_measure"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "storage_items", ["slug"], name: "index_storage_items_on_slug", unique: true, using: :btree

  create_table "testimonies", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
