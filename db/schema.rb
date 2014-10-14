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

ActiveRecord::Schema.define(version: 20141014154721) do

  create_table "addresses", force: true do |t|
    t.string   "receiver"
    t.string   "name"
    t.string   "post_code"
    t.integer  "area_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.boolean  "default"
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

  create_table "order_statuses", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "public_name"
  end

  create_table "order_storage_item_statuses", force: true do |t|
    t.string   "name"
    t.string   "public_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_storage_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "storage_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "order_storage_item_status_id"
    t.decimal  "price",                        precision: 10, scale: 0
    t.datetime "in_warehouse_date"
  end

  create_table "order_storage_items_payments", id: false, force: true do |t|
    t.integer "payment_id"
    t.integer "order_storage_item_id"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "address_id"
    t.integer  "order_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "delivery_date"
    t.string   "delivery_time"
    t.datetime "collection_date"
    t.string   "collection_time"
    t.string   "company_name"
    t.string   "company_rut"
    t.boolean  "concierge"
    t.boolean  "neighbour"
  end

  create_table "payment_months", force: true do |t|
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_months_payments", id: false, force: true do |t|
    t.integer "payment_id"
    t.integer "payment_month_id"
  end

  create_table "payment_statuses", force: true do |t|
    t.string   "name"
    t.string   "public_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_types", force: true do |t|
    t.string   "name"
    t.string   "public_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.decimal  "amount",            precision: 10, scale: 0
    t.integer  "payment_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_type_id"
  end

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
    t.string   "public_name"
  end

  add_index "storage_items", ["slug"], name: "index_storage_items_on_slug", unique: true, using: :btree

  create_table "stored_items", force: true do |t|
    t.integer  "order_storage_item_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "assigned_value",        precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
  end

  create_table "subscribers", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "item_photo_file_name"
    t.string   "item_photo_content_type"
    t.integer  "item_photo_file_size"
    t.datetime "item_photo_updated_at"
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
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
