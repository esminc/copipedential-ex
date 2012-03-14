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

ActiveRecord::Schema.define(:version => 20120314060846) do

  create_table "filetypes", :force => true do |t|
    t.string  "name",                          :null => false
    t.boolean "renderable", :default => false
  end

  create_table "hooks", :force => true do |t|
    t.string   "name",       :limit => 50,                   :null => false
    t.string   "backend",    :limit => 50
    t.text     "config"
    t.boolean  "active",                   :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentions", :force => true do |t|
    t.integer "snippet_id",   :null => false
    t.integer "mentioned_id", :null => false
  end

  add_index "mentions", ["snippet_id", "mentioned_id"], :name => "index_mentions_on_snippet_id_and_mentioned_id"

  create_table "pictures", :force => true do |t|
    t.string   "name",        :limit => 50
    t.string   "description"
    t.string   "key",                       :null => false
    t.integer  "author_id",                 :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "pictures", ["author_id"], :name => "index_pictures_on_author_id"

  create_table "snippets", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id",                  :null => false
    t.string   "description", :limit => 200
    t.integer  "filetype_id"
  end

  create_table "users", :force => true do |t|
    t.string   "nickname",      :limit => 32, :null => false
    t.integer  "uid",                         :null => false
    t.string   "provider",      :limit => 30, :null => false
    t.string   "gravatar",      :limit => 32
    t.datetime "authorized_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["provider", "uid"], :name => "index_users_on_provider_and_uid"

end
