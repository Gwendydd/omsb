# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080916215133) do

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.string   "dates"
    t.string   "alias"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "date_begin"
    t.integer  "date_end"
    t.boolean  "date_circa"
    t.string   "date_type",  :limit => 12
    t.text     "bio"
  end

  create_table "authorships", :force => true do |t|
    t.integer  "author_id"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "role_id",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "rolename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.string   "text_name"
    t.string   "author"
    t.string   "editor"
    t.string   "link"
    t.boolean  "facsimile",     :limit => 255
    t.integer  "date_begin"
    t.integer  "date_end"
    t.string   "language"
    t.boolean  "trans_none"
    t.boolean  "trans_english"
    t.boolean  "trans_french"
    t.boolean  "trans_other"
    t.string   "country"
    t.string   "region"
    t.string   "type"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.string   "my_id",            :limit => 20
    t.string   "editor"
    t.string   "title"
    t.string   "publication"
    t.string   "pub_date",         :limit => 20
    t.string   "isbn",             :limit => 13
    t.integer  "text_pages",       :limit => 5
    t.boolean  "trans_english",                  :default => false
    t.boolean  "trans_french",                   :default => false
    t.boolean  "trans_other",                    :default => false
    t.boolean  "trans_none",                     :default => false
    t.integer  "date_begin",       :limit => 4
    t.integer  "date_end",         :limit => 4
    t.string   "region"
    t.string   "archive"
    t.string   "link"
    t.boolean  "app_index",                      :default => false
    t.boolean  "app_glossary",                   :default => false
    t.boolean  "app_appendix",                   :default => false
    t.boolean  "app_bibliography",               :default => false
    t.boolean  "app_facsimile",                  :default => false
    t.boolean  "app_intro",                      :default => false
    t.text     "comments"
    t.text     "intro_summary"
    t.text     "addenda"
    t.boolean  "live",                           :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trans_comment"
    t.text     "text_name"
    t.string   "cataloger"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "initials"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "password_reset_code",       :limit => 40
    t.boolean  "enabled",                                 :default => true
  end

end
