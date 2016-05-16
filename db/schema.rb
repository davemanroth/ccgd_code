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

ActiveRecord::Schema.define(version: 20160516193224) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street",     limit: 255
    t.string   "city",       limit: 255
    t.string   "country",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "state_id",   limit: 4
  end

  create_table "lab_groups", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "location_id", limit: 4
  end

  create_table "locations", force: :cascade do |t|
    t.string   "building",   limit: 255
    t.string   "room",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "address_id", limit: 4
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "lab_group_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "address_id", limit: 4
  end

  create_table "platforms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "privileges", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "role_id",    limit: 4, null: false
  end

  add_index "privileges", ["role_id"], name: "index_privileges_on_role_id", using: :btree
  add_index "privileges", ["user_id"], name: "index_privileges_on_user_id", using: :btree

  create_table "proposal_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "code",                limit: 10
    t.text     "objectives",          limit: 65535
    t.text     "background",          limit: 65535
    t.text     "design_details",      limit: 65535
    t.text     "sample_availability", limit: 65535
    t.text     "contributions",       limit: 65535
    t.text     "comments",            limit: 65535
    t.string   "financial_contact",   limit: 255
    t.string   "billing_dept",        limit: 255
    t.string   "billing_street",      limit: 255
    t.string   "billing_building",    limit: 255
    t.string   "billing_room",        limit: 255
    t.string   "billing_city",        limit: 255
    t.string   "billing_zip",         limit: 255
    t.string   "billing_email",       limit: 255
    t.string   "billing_phone",       limit: 255
    t.integer  "state_id",            limit: 4
    t.integer  "proposal_status_id",  limit: 4
    t.integer  "platform_id",         limit: 4
    t.integer  "user_id",             limit: 4
    t.integer  "lab_group_id",        limit: 4
    t.boolean  "submitted",                         default: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "proposals", ["lab_group_id"], name: "index_proposals_on_lab_group_id", using: :btree
  add_index "proposals", ["platform_id"], name: "index_proposals_on_platform_id", using: :btree
  add_index "proposals", ["proposal_status_id"], name: "index_proposals_on_proposal_status_id", using: :btree
  add_index "proposals", ["state_id"], name: "index_proposals_on_state_id", using: :btree
  add_index "proposals", ["user_id"], name: "index_proposals_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_custom_labgroups", force: :cascade do |t|
    t.string   "custom_labgroup_name",     limit: 255
    t.string   "custom_labgroup_code",     limit: 255
    t.string   "custom_labgroup_building", limit: 255
    t.string   "custom_labgroup_room",     limit: 255
    t.string   "custom_street",            limit: 255
    t.string   "custom_city",              limit: 255
    t.string   "custom_country",           limit: 255
    t.integer  "state_id",                 limit: 4
    t.integer  "user_id",                  limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "user_custom_organizations", force: :cascade do |t|
    t.string   "custom_org_name",  limit: 255
    t.string   "custom_org_phone", limit: 255
    t.string   "custom_org_email", limit: 255
    t.string   "custom_street",    limit: 255
    t.string   "custom_city",      limit: 255
    t.string   "custom_country",   limit: 255
    t.integer  "state_id",         limit: 4
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname",              limit: 255
    t.string   "lastname",               limit: 255
    t.string   "email",                  limit: 255
    t.string   "phone",                  limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "username",               limit: 255
    t.string   "password_digest",        limit: 255
    t.integer  "organization_id",        limit: 4
    t.string   "status",                 limit: 2
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
  end

end
