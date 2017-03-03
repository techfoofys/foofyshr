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

ActiveRecord::Schema.define(version: 20170303113433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "designations", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "doc_image_id"
    t.index ["user_id"], name: "index_documents_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.date     "event_date"
    t.integer  "status_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["status_id"], name: "index_events_on_status_id", using: :btree
  end

  create_table "instalments", force: :cascade do |t|
    t.integer  "project_id"
    t.date     "instalment_date"
    t.decimal  "amount"
    t.integer  "instalment_no"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["project_id"], name: "index_instalments_on_project_id", using: :btree
  end

  create_table "invites", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leave_applications", force: :cascade do |t|
    t.date     "from"
    t.date     "to"
    t.string   "reason"
    t.boolean  "status"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leave_applications_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "total_budget"
    t.date     "from"
    t.date     "to"
    t.integer  "no_instalments"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "status",         default: true
  end

  create_table "roles", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "salaries", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.decimal  "initial_amount_per_month"
    t.integer  "prov_period"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_salaries_on_user_id", using: :btree
  end

  create_table "salary_transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "month"
    t.decimal  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "partial"
    t.index ["user_id"], name: "index_salary_transactions_on_user_id", using: :btree
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "title"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "doj"
    t.date     "dob"
    t.text     "address"
    t.text     "per_address"
    t.integer  "role_id"
    t.integer  "designation_id"
    t.integer  "status_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "probation"
    t.string   "profile_image_id"
    t.index ["designation_id"], name: "index_user_profiles_on_designation_id", using: :btree
    t.index ["role_id"], name: "index_user_profiles_on_role_id", using: :btree
    t.index ["status_id"], name: "index_user_profiles_on_status_id", using: :btree
    t.index ["user_id"], name: "index_user_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "users_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_users_projects_on_project_id", using: :btree
    t.index ["user_id"], name: "index_users_projects_on_user_id", using: :btree
  end

  add_foreign_key "documents", "users"
  add_foreign_key "events", "statuses"
  add_foreign_key "instalments", "projects"
  add_foreign_key "leave_applications", "users"
  add_foreign_key "salaries", "users"
  add_foreign_key "salary_transactions", "users"
  add_foreign_key "user_profiles", "designations"
  add_foreign_key "user_profiles", "roles"
  add_foreign_key "user_profiles", "statuses"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "users_projects", "projects"
  add_foreign_key "users_projects", "users"
end
