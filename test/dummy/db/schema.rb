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

ActiveRecord::Schema.define(version: 20181116141024) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "subtitle"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "policy_manager_policies", force: :cascade do |t|
    t.string   "policy_type"
    t.text     "content"
    t.integer  "version"
    t.boolean  "blocking"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

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

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
