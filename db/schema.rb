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

ActiveRecord::Schema.define(:version => 20111214212356) do

  create_table "aliases", :force => true do |t|
    t.string   "assembly_uuid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "amendments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.text     "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assemblies", :id => false, :force => true do |t|
    t.string   "uuid",            :limit => 36
    t.integer  "user_id"
    t.string   "name",                                          :null => false
    t.integer  "category_id",                                   :null => false
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.integer  "super_majority",                :default => 66
    t.integer  "theme_id",                      :default => 1
    t.string   "web_address"
    t.string   "public_email"
    t.string   "public_phone"
    t.integer  "flag_threshold"
    t.integer  "block_threshold",               :default => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assembly_document_repositories", :force => true do |t|
    t.string   "assembly_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", :force => true do |t|
    t.integer  "user_id"
    t.string   "assembly_uuid"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "binding_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bindable_id"
    t.string   "bindable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blocks", :force => true do |t|
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", :force => true do |t|
    t.integer  "flaggable_id"
    t.string   "flaggable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferences", :force => true do |t|
    t.integer  "preferable_id"
    t.string   "preferable_type"
    t.string   "name"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", :force => true do |t|
    t.string   "assembly_uuid"
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registration_numbers", :force => true do |t|
    t.string   "assembly_uuid"
    t.string   "uuid"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "replyable_id"
    t.string   "replyable_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxonomies", :force => true do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tag_id"
    t.string   "assembly_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "name"
    t.string   "city"
    t.string   "locale",                                :default => "en"
    t.boolean  "is_admin",                              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.integer  "upvote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
