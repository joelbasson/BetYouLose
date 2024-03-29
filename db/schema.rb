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

ActiveRecord::Schema.define(:version => 20110311213052) do

  create_table "bets", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "end_date"
    t.integer  "wager_amount"
    t.text     "verify_description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "verified",           :default => false
    t.boolean  "confirmed",          :default => false
    t.string   "display_name"
    t.integer  "wagers_count",       :default => 0
    t.string   "status",             :default => "Undecided"
  end

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "purchase_id"
  end

  create_table "purchases", :force => true do |t|
    t.integer  "wallet_id"
    t.integer  "amount"
    t.integer  "user_id"
    t.decimal  "value",        :precision => 8, :scale => 2
    t.datetime "purchased_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "wallet_id"
    t.string   "description"
    t.integer  "bet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "rpx_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                               :default => false
    t.integer  "wallet_id"
    t.string   "display_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wagers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bet_id"
    t.boolean  "against",    :default => false
    t.integer  "credits",    :default => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wallets", :force => true do |t|
    t.integer  "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
