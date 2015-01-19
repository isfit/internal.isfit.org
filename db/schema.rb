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

ActiveRecord::Schema.define(version: 20150119003805) do

  create_table "accounts", force: true do |t|
    t.string   "name_nb"
    t.string   "name_en"
    t.integer  "section_id"
    t.integer  "account_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact_email"
  end

  add_index "accounts", ["section_id"], name: "index_accounts_on_section_id", using: :btree

  create_table "answers", force: true do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.text     "content"
    t.integer  "user_id"
  end

  create_table "applicants", id: false, force: true do |t|
    t.integer  "id",                    default: 0,     null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mail"
    t.integer  "phone"
    t.text     "information"
    t.text     "background"
    t.text     "heardof"
    t.integer  "position_id_1"
    t.integer  "position_id_2"
    t.integer  "position_id_3"
    t.integer  "status",                default: 0
    t.text     "comment"
    t.string   "interview_place_1"
    t.string   "interview_place_2"
    t.string   "interview_place_3"
    t.datetime "interview_time_1"
    t.datetime "interview_time_2"
    t.datetime "interview_time_3"
    t.integer  "interviewer_id_1_1"
    t.integer  "interviewer_id_1_2"
    t.integer  "interviewer_id_2_1"
    t.integer  "interviewer_id_2_2"
    t.integer  "interviewer_id_3_1"
    t.integer  "interviewer_id_3_2"
    t.boolean  "deleted",               default: false
    t.string   "username"
    t.string   "password"
    t.string   "dn"
    t.boolean  "has_account",           default: false
    t.integer  "is_notified",           default: 0
    t.string   "birthyear"
    t.string   "place_of_study"
    t.integer  "applicant_user_id"
    t.boolean  "locked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recruited_position_id"
  end

  create_table "applications", force: true do |t|
    t.string   "first_name",                                           null: false
    t.string   "last_name",                                            null: false
    t.string   "address",                                              null: false
    t.string   "zipcode",                  limit: 10,                  null: false
    t.string   "city",                                                 null: false
    t.integer  "country_id",                           default: 0,     null: false
    t.string   "phone",                    limit: 64,                  null: false
    t.string   "email",                    limit: 100,                 null: false
    t.date     "birthdate",                                            null: false
    t.string   "sex",                      limit: 2,                   null: false
    t.string   "university",                                           null: false
    t.string   "field_of_study",                                       null: false
    t.integer  "workshop1",                            default: 0,     null: false
    t.integer  "workshop2",                            default: 0,     null: false
    t.integer  "workshop3",                            default: 0,     null: false
    t.text     "essay1",                                               null: false
    t.text     "essay2",                                               null: false
    t.integer  "travel_apply",             limit: 1,   default: 0
    t.text     "travel_essay"
    t.string   "travel_amount",            limit: 20,  default: ""
    t.integer  "travel_nosupport_other",   limit: 1,   default: 0
    t.integer  "travel_nosupport_cancome", limit: 1,   default: 0
    t.integer  "grade1_functionary_id",                default: 0,     null: false
    t.integer  "grade1",                   limit: 2,   default: 0,     null: false
    t.text     "grade1_comment"
    t.integer  "grade2_functionary_id",                default: 0,     null: false
    t.integer  "grade2",                   limit: 2,   default: 0,     null: false
    t.text     "grade2_comment"
    t.integer  "total_grade",              limit: 2,   default: 0,     null: false
    t.integer  "selection_functionary_id",             default: 0,     null: false
    t.text     "selection_comment"
    t.integer  "travel_functionary_id",                default: 0,     null: false
    t.integer  "travel_approved",          limit: 1,   default: 0,     null: false
    t.string   "travel_amount_given",                  default: "0",   null: false
    t.text     "travel_comment"
    t.integer  "status",                               default: 0,     null: false
    t.integer  "final_workshop",                       default: 0,     null: false
    t.boolean  "deleted",                              default: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "travel_status",                        default: 0,     null: false
  end

  create_table "arrival_places", force: true do |t|
    t.string "name"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.boolean  "sticky"
    t.datetime "end_at"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "article_image_file_name"
    t.string   "article_image_content_type"
    t.integer  "article_image_file_size"
    t.datetime "article_image_updated_at"
    t.boolean  "attending",                  default: false
  end

  create_table "articles_attendings", force: true do |t|
    t.integer "article_id"
    t.integer "user_id"
  end

  create_table "awesomes", force: true do |t|
    t.integer  "user_id"
    t.integer  "kvitter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "awesomes", ["kvitter_id"], name: "index_awesomes_on_kvitter_id", using: :btree
  add_index "awesomes", ["user_id"], name: "index_awesomes_on_user_id", using: :btree

  create_table "campaign_stories", id: false, force: true do |t|
    t.integer  "id",                    default: 0,     null: false
    t.string   "author"
    t.text     "story"
    t.integer  "continent_id"
    t.integer  "author_nationality_id"
    t.integer  "happened_in_id"
    t.string   "email"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "solution"
    t.boolean  "validated",             default: false
    t.boolean  "deleted",               default: false
  end

  create_table "card_checkers", force: true do |t|
    t.boolean  "samfundet_card"
    t.boolean  "ntnu_card"
    t.boolean  "check_card"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "card_checkers", ["user_id"], name: "index_card_checkers_on_user_id", using: :btree

  create_table "cars", force: true do |t|
    t.string   "description"
    t.string   "space"
    t.integer  "seats"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
  end

  create_table "contact_log_people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.integer  "contact_log_unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "role"
    t.integer  "contact_log_status_id"
  end

  create_table "contact_log_statuses", force: true do |t|
    t.string   "status"
    t.string   "color_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_log_units", force: true do |t|
    t.string   "company_name"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "contact_log_status_id"
  end

  create_table "contact_logs", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "contact_log_person_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "continents", id: false, force: true do |t|
    t.integer  "id",           default: 0, null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

  create_table "control_panels", force: true do |t|
    t.boolean  "app_grade1",       default: false
    t.boolean  "app_grade2",       default: false
    t.boolean  "app_grade3",       default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "app_grade2_scope"
  end

