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

ActiveRecord::Schema.define(version: 20190225102925) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "subtitle"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "policy_manager_logs", force: :cascade do |t|
    t.string   "log_type"
    t.string   "description"
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "policy_manager_logs", ["loggable_type", "loggable_id"], name: "index_policy_manager_logs_on_loggable_type_and_loggable_id"
  add_index "policy_manager_logs", ["user_id"], name: "index_policy_manager_logs_on_user_id"

  create_table "policy_manager_policies", force: :cascade do |t|
    t.string   "policy_type"
    t.integer  "version"
    t.boolean  "blocking"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "policy_manager_policy_translations", force: :cascade do |t|
    t.integer  "policy_manager_policy_id", null: false
    t.string   "locale",                   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name"
    t.text     "content"
  end

  add_index "policy_manager_policy_translations", ["locale"], name: "index_policy_manager_policy_translations_on_locale"
  add_index "policy_manager_policy_translations", ["policy_manager_policy_id"], name: "index_229d115d14bcace48ce8ef4bbac83deee452f49d"

  create_table "policy_manager_portability_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "attachment"
    t.string   "attachment_file_name"
    t.string   "attachment_file_size"
    t.string   "attachment_content_type"
    t.string   "attachment_file_content_type"
    t.datetime "job_completed_at"
    t.datetime "job_failed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "policy_manager_portability_requests", ["user_id"], name: "index_policy_manager_portability_requests_on_user_id"

  create_table "policy_manager_user_policies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "policy_id"
    t.boolean  "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "policy_manager_user_policies", ["policy_id"], name: "index_policy_manager_user_policies_on_policy_id"
  add_index "policy_manager_user_policies", ["user_id"], name: "index_policy_manager_user_policies_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
