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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110517131957) do

  create_table "addresses", :force => true do |t|
    t.string   "street1",          :limit => 128
    t.string   "street2",          :limit => 128
    t.string   "city",             :limit => 64
    t.string   "state",            :limit => 18
    t.string   "zipcode",          :limit => 10
    t.string   "address_type"
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.boolean  "current"
    t.string   "full_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["addressable_type", "addressable_id"], :name => "add_index_to_addresses_type_and_id"

  create_table "comments", :force => true do |t|
    t.string    "commentable_type"
    t.integer   "commentable_id"
    t.text      "content"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string    "name"
    t.string    "cached_slug"
    t.string    "phone",        :limit => 128
    t.string    "street1",      :limit => 128
    t.string    "street2",      :limit => 128
    t.string    "city",         :limit => 64
    t.string    "state",        :limit => 32
    t.string    "zipcode",      :limit => 32
    t.string    "full_address"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string    "firstname"
    t.string    "lastname"
    t.string    "email"
    t.string    "street1"
    t.string    "street2"
    t.string    "city"
    t.string    "state"
    t.string    "zipcode"
    t.string    "full_address"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "company_id"
    t.string    "customer_number"
    t.string    "c_height",        :limit => 16
    t.string    "gender",          :limit => 16
    t.string    "race",            :limit => 64
    t.date      "dob"
  end

  add_index "customers", ["company_id"], :name => "index_customers_on_company_id"

  create_table "employmentships", :force => true do |t|
    t.integer   "user_id"
    t.integer   "company_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer   "company_id"
    t.integer   "customer_id"
    t.integer   "title_loan_id"
    t.decimal   "loan_payment"
    t.decimal   "amount_paid"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
  end

  add_index "orders", ["company_id"], :name => "index_orders_on_company_id"

  create_table "photos", :force => true do |t|
    t.integer  "title_loan_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slugs", :force => true do |t|
    t.string    "name"
    t.integer   "sluggable_id"
    t.integer   "sequence",                     :default => 1, :null => false
    t.string    "sluggable_type", :limit => 40
    t.string    "scope"
    t.timestamp "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "assigned_to"
    t.integer  "completed_by"
    t.string   "name"
    t.integer  "asset_id"
    t.string   "asset_type"
    t.string   "category"
    t.date     "due_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  add_index "tasks", ["asset_id", "asset_type"], :name => "index_tasks_on_asset_id_and_asset_type"
  add_index "tasks", ["company_id", "assigned_to"], :name => "index_tasks_on_company_id_and_assigned_to"
  add_index "tasks", ["deleted_at"], :name => "index_tasks_on_deleted_at"

  create_table "title_loans", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "company_id"
    t.string   "vin",              :limit => 128
    t.string   "make",             :limit => 128
    t.string   "vin_model",        :limit => 128
    t.string   "style",            :limit => 128
    t.string   "color",            :limit => 128
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "closed_date"
    t.integer  "closed_by"
    t.decimal  "loan_amount"
    t.integer  "parent_id"
    t.integer  "payments_made",                   :default => 0
    t.decimal  "base_amount"
    t.decimal  "previous_balance",                :default => 0.0
    t.string   "tag_number",       :limit => 16
    t.date     "due_date"
    t.integer  "user_id"
  end

  add_index "title_loans", ["company_id"], :name => "index_title_loans_on_company_id"

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "full_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",   :limit => 128,                :null => false
    t.string   "password_salt",                                      :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "roles_mask"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username"

end
