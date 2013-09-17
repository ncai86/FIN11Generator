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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130917073152) do

  create_table "acquirers", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "base_currency_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "base_currencies", :force => true do |t|
    t.string   "currency"
    t.integer  "configuration_name_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "configuration_fields", :force => true do |t|
    t.string   "name"
    t.string   "default_value"
    t.string   "state"
    t.integer  "configuration_name_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "character_limit"
  end

  create_table "configuration_names", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "currency_merchant_groups", :force => true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.integer  "acquirer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
