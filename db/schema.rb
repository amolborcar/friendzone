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

ActiveRecord::Schema.define(:version => 20140829192938) do

  create_table "followers", :force => true do |t|
    t.string   "screen_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
  end

  create_table "friends", :force => true do |t|
    t.string   "screen_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
  end

  create_table "tweets", :force => true do |t|
    t.text     "id_str"
    t.datetime "tweet_created_at"
    t.text     "tweet_text"
    t.text     "user_who_posted"
    t.text     "retweeted_status"
    t.text     "retweeted"
    t.boolean  "mention"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.text   "screen_name"
    t.string "token_key"
    t.string "token_secret"
    t.string "name"
  end

end
