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

ActiveRecord::Schema.define(version: 20160519013023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "course_number"
  end

  add_index "courses", ["department_id"], name: "index_courses_on_department_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "subject_code"
  end

  create_table "experiences", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "skill_id",   null: false
    t.integer "value"
  end

  create_table "problems", force: :cascade do |t|
    t.jsonb    "assignments", default: {}, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "requirements", force: :cascade do |t|
    t.integer "course_id",     null: false
    t.integer "skill_id",      null: false
    t.integer "instructor_id"
    t.integer "value"
  end

  create_table "section_preferences", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "section_id"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "max_enrollment"
    t.integer  "current_enrollment"
    t.integer  "course_id"
    t.string   "cc_instructor_tag"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "term"
    t.integer  "location"
    t.string   "section"
    t.string   "type"
    t.string   "status"
  end

  add_index "sections", ["course_id"], name: "index_sections_on_course_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "type"
  end

  create_table "student_preferences", force: :cascade do |t|
    t.integer  "section_id"
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.float    "fte",                    default: 0.0
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_administrator",       default: false
    t.string   "cc_instructor_tag"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "courses", "departments"
  add_foreign_key "sections", "courses"
end
