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

ActiveRecord::Schema.define(version: 20141020165130) do

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

  create_table "countries", id: false, force: true do |t|
    t.integer "id",                  default: 0, null: false
    t.string  "name"
    t.integer "region_id"
    t.string  "code",      limit: 4
  end

  create_table "deadlines", force: true do |t|
    t.datetime "deadline"
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "participant_type", default: 0
  end

  create_table "deadlines_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "deadline_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "approved",    default: false
  end

  create_table "dialogue_participants", id: false, force: true do |t|
    t.integer  "id",                                   default: 0,     null: false
    t.datetime "registered_time",                                      null: false
    t.string   "first_name",                                           null: false
    t.string   "middle_name",              limit: 64
    t.string   "last_name",                                            null: false
    t.string   "address1",                             default: "",    null: false
    t.string   "address2"
    t.string   "zipcode",                  limit: 10,  default: "",    null: false
    t.string   "city",                                 default: "",    null: false
    t.integer  "country_id",                           default: 0,     null: false
    t.string   "phone",                    limit: 20,  default: "",    null: false
    t.string   "email",                    limit: 100, default: "",    null: false
    t.string   "fax",                      limit: 20
    t.string   "nationality",                          default: "",    null: false
    t.string   "passport",                             default: "",    null: false
    t.date     "birthdate",                                            null: false
    t.string   "sex",                      limit: 2,   default: "",    null: false
    t.string   "university",                           default: "",    null: false
    t.string   "field_of_study",                                       null: false
    t.string   "org_name"
    t.string   "org_function"
    t.string   "hear_about_isfit"
    t.string   "hear_about_isfit_other"
    t.text     "essay1",                                               null: false
    t.text     "essay2",                                               null: false
    t.text     "essay3",                                               null: false
    t.text     "essay4",                                               null: false
    t.integer  "travel_apply",             limit: 1,   default: 0
    t.text     "travel_essay"
    t.string   "travel_amount",            limit: 20
    t.integer  "travel_nosupport_other",   limit: 1,   default: 0
    t.integer  "travel_nosupport_cancome", limit: 1,   default: 0
    t.integer  "apply_workshop",           limit: 1,   default: 0
    t.integer  "invited",                  limit: 1,   default: 0,     null: false
    t.string   "password"
    t.datetime "last_login"
    t.boolean  "notified_invited",                     default: false, null: false
    t.boolean  "notified_rejected",                    default: false, null: false
  end

  create_table "drivers", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "drivers", ["user_id"], name: "index_drivers_on_user_id", using: :btree

  create_table "drives", force: true do |t|
    t.integer  "driver_id"
    t.integer  "car_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.text     "comment"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "status"
    t.integer  "group_id"
    t.integer  "user_id"
  end

  add_index "drives", ["car_id"], name: "index_drives_on_car_id", using: :btree
  add_index "drives", ["driver_id"], name: "index_drives_on_driver_id", using: :btree

  create_table "festivals", id: false, force: true do |t|
    t.integer "id",   default: 0, null: false
    t.integer "year"
  end

  create_table "frontend_article_frontend_hashtags", force: true do |t|
    t.integer  "frontend_article_id"
    t.integer  "frontend_hashtag_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "frontend_articles", force: true do |t|
    t.string   "title_en"
    t.string   "title_no"
    t.text     "ingress_en"
    t.text     "ingress_no"
    t.text     "body_en"
    t.text     "body_no"
    t.boolean  "list"
    t.integer  "weight"
    t.datetime "created_at"
    t.boolean  "deleted"
    t.integer  "press_release",                       limit: 1
    t.string   "sub_title_no"
    t.string   "sub_title_en"
    t.string   "image_text_no"
    t.string   "image_text_en"
    t.boolean  "main_article"
    t.boolean  "published"
    t.string   "byline"
    t.integer  "byline_user_id"
    t.string   "image_credits"
    t.integer  "mail_sent"
    t.datetime "show_article"
    t.boolean  "got_comments",                                  default: false
    t.string   "frontend_article_image_file_name"
    t.string   "frontend_article_image_content_type"
    t.integer  "frontend_article_image_file_size"
    t.datetime "frontend_article_image_updated_at"
    t.text     "sidebar"
    t.boolean  "blog",                                          default: false
    t.string   "frontend_tag"
  end

  create_table "frontend_hashtags", force: true do |t|
    t.string   "hashtag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "functionaries", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "functionaries_participants", id: false, force: true do |t|
    t.integer  "functionary_id"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "gallery_albums", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "gallery_albums", ["user_id"], name: "index_gallery_albums_on_user_id", using: :btree

  create_table "gallery_photos", force: true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "gallery_album_id"
  end

  add_index "gallery_photos", ["user_id"], name: "index_gallery_photos_on_user_id", using: :btree

  create_table "groups", id: false, force: true do |t|
    t.integer "id",                          default: 0, null: false
    t.string  "name_en"
    t.string  "name_no"
    t.integer "section_id"
    t.integer "festival_id"
    t.string  "email",          limit: 1000
    t.string  "tag",                                     null: false
    t.text    "description_en"
    t.text    "description_no"
  end

  create_table "groups_positions", id: false, force: true do |t|
    t.integer "group_id"
    t.integer "position_id"
  end

  create_table "hashtags_kvitters", force: true do |t|
    t.integer "kvitter_id"
    t.integer "hashtag_id"
  end

  create_table "hosts", id: false, force: true do |t|
    t.integer  "id",         default: 0,     null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.integer  "zipcode"
    t.string   "place"
    t.integer  "number"
    t.text     "other"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "student"
    t.boolean  "deleted",    default: false
  end

  create_table "information_categories", force: true do |t|
    t.string "title"
  end

  create_table "information_pages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "information_category_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "internal_tabs", force: true do |t|
    t.string   "title"
    t.string   "tag"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "action_id"
  end

  add_index "internal_tabs", ["ancestry"], name: "index_internal_tabs_on_ancestry", using: :btree

  create_table "isfit_pages", force: true do |t|
    t.string  "title_en",                   null: false
    t.string  "title_no",                   null: false
    t.text    "ingress_en",                 null: false
    t.text    "ingress_no",                 null: false
    t.text    "body_en",                    null: false
    t.text    "body_no",                    null: false
    t.string  "tag",                        null: false
    t.boolean "deleted",    default: false, null: false
    t.integer "tab_id"
    t.integer "tab_weight", default: -1
  end

  create_table "isfit_parliaments", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "phone"
    t.integer  "years_work_lost"
    t.string   "place_of_study"
    t.string   "remember_date"
    t.string   "why_attend"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "isfit_tabs", force: true do |t|
    t.string   "name_en"
    t.string   "name_no"
    t.string   "tag_no"
    t.string   "tag_en"
    t.string   "path"
    t.integer  "weight"
    t.string   "icon"
    t.boolean  "deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kvitters", force: true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teller"
  end

  create_table "layout_jobs", force: true do |t|
    t.integer  "user_id"
    t.text     "user_info"
    t.string   "work_title"
    t.date     "deadline"
    t.integer  "publishing"
    t.string   "format"
    t.text     "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "status"
    t.integer  "group_id"
    t.integer  "owner_id"
    t.integer  "number",         default: 1
    t.date     "last_proofread"
  end

  create_table "motds", force: true do |t|
    t.string   "msg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pads", force: true do |t|
    t.string   "hexid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participant_quotes", force: true do |t|
    t.string   "quote",      limit: 700
    t.integer  "user_id"
    t.string   "category"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "participant_quotes", ["user_id"], name: "index_participant_quotes_on_user_id", using: :btree

  create_table "participants", id: false, force: true do |t|
    t.integer  "id",                         default: 0,  null: false
    t.string   "email",                      default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.integer  "sex",              limit: 1
    t.date     "birthdate"
    t.string   "citizenship"
    t.integer  "country_id"
    t.integer  "citizenship_id"
    t.string   "nationality"
    t.text     "motivation_essay",                        null: false
    t.integer  "workshop1"
    t.integer  "workshop2"
    t.integer  "workshop3"
    t.text     "workshop_essay",                          null: false
    t.datetime "registered_time",                         null: false
    t.string   "travel_amount"
  end

  create_table "photos", force: true do |t|
    t.string   "image_text_en"
    t.string   "image_text_no"
    t.string   "description"
    t.string   "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_picture_file_name"
    t.string   "original_picture_content_type"
    t.integer  "original_picture_file_size"
    t.datetime "original_picture_updated_at"
    t.string   "half_article_picture_file_name"
    t.string   "half_article_picture_content_type"
    t.integer  "half_article_picture_file_size"
    t.datetime "half_article_picture_updated_at"
    t.string   "full_article_picture_file_name"
    t.string   "full_article_picture_content_type"
    t.integer  "full_article_picture_file_size"
    t.datetime "full_article_picture_updated_at"
    t.string   "spp_one_third_article_picture_file_name"
    t.string   "spp_one_third_article_picture_content_type"
    t.integer  "spp_one_third_article_picture_file_size"
    t.datetime "spp_one_third_article_picture_updated_at"
    t.string   "spp_full_article_picture_file_name"
    t.string   "spp_full_article_picture_content_type"
    t.integer  "spp_full_article_picture_file_size"
    t.datetime "spp_full_article_picture_updated_at"
  end

  create_table "positions", id: false, force: true do |t|
    t.integer  "id",             default: 0, null: false
    t.string   "title_en"
    t.string   "title_no"
    t.integer  "user_id"
    t.text     "description_en"
    t.text     "description_no"
    t.string   "group_dn"
    t.integer  "admission_id"
    t.integer  "group_id"
    t.integer  "number",         default: 1, null: false
    t.datetime "publish_from"
    t.datetime "publish_to"
  end

  create_table "positions_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "position_id", null: false
  end

  create_table "presentations", force: true do |t|
    t.string   "title"
    t.text     "markdown_text"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "presentations", ["user_id"], name: "index_presentations_on_user_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "citizenship"
    t.integer  "calling_code"
    t.integer  "phone"
    t.date     "date_of_birth"
    t.integer  "gender",           limit: 1
    t.string   "gender_specify"
    t.string   "school"
    t.string   "field_of_study"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "country_id"
    t.integer  "citizenship_id"
    t.string   "nationality"
    t.text     "motivation_essay",           null: false
  end

  create_table "questions", force: true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "dialogue"
    t.integer  "participant_id"
    t.integer  "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "question_id"
  end

  create_table "regions", force: true do |t|
    t.string "name"
  end

  create_table "roles", id: false, force: true do |t|
    t.integer  "id",         default: 0, null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer  "role_id",    null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_bookings", force: true do |t|
    t.datetime "reserved_at"
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", id: false, force: true do |t|
    t.integer "id",                          default: 0, null: false
    t.string  "name_en"
    t.string  "name_no"
    t.integer "festival_id"
    t.string  "email",          limit: 1000
    t.string  "tag",                                     null: false
    t.text    "description_en"
    t.text    "description_no"
  end

  create_table "shifts", force: true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "driver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spp_articles", force: true do |t|
    t.string   "title_en"
    t.string   "title_no"
    t.text     "ingress_en"
    t.text     "ingress_no"
    t.text     "body_en"
    t.text     "body_no"
    t.boolean  "press_release"
    t.boolean  "deleted"
    t.boolean  "visible"
    t.string   "image_text"
    t.boolean  "main_article"
    t.integer  "weight"
    t.boolean  "got_comments"
    t.string   "youtube_link"
    t.integer  "byline_user_id"
    t.string   "byline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spp_article_image_file_name"
    t.string   "spp_article_image_content_type"
    t.integer  "spp_article_image_file_size"
    t.datetime "spp_article_image_updated_at"
  end

  create_table "spp_pages", id: false, force: true do |t|
    t.integer  "id",             default: 0, null: false
    t.string   "title_en"
    t.text     "ingress_en"
    t.text     "body_en"
    t.string   "image_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "byline_func_id"
    t.string   "byline"
    t.string   "title_no"
    t.text     "ingress_no"
    t.text     "body_no"
  end

  create_table "static_pages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "static_pages", ["user_id"], name: "index_static_pages_on_user_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "subscription_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transport_responsibles", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transport_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: false, force: true do |t|
    t.integer  "id",                                     default: 0, null: false
    t.string   "given_name"
    t.string   "family_name"
    t.date     "date_of_birth"
    t.integer  "gender"
    t.string   "phone"
    t.string   "address"
    t.integer  "postal_code"
    t.integer  "country_id"
    t.string   "next_of_kin_name"
    t.string   "next_of_kin_tlf"
    t.text     "tasks"
    t.string   "study"
    t.integer  "study_place_id"
    t.string   "private_email"
    t.integer  "cardnumber_ntnu"
    t.integer  "cardnumber_samfundet"
    t.string   "city"
    t.string   "username"
    t.integer  "ldap_id"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.integer  "has_skies"
    t.integer  "shoe_size"
    t.integer  "have_group_card"
    t.text     "media_contacts"
    t.string   "local_paper"
    t.integer  "vegetarian",                   limit: 1
    t.integer  "lactose_allergy",              limit: 1
    t.integer  "gluten_allergy",               limit: 1
    t.integer  "nut_allergy",                  limit: 1
    t.integer  "fruit_allergy",                limit: 1
    t.text     "other_allergy"
    t.integer  "no_allergy",                   limit: 1
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_username"
    t.string   "facebook_id"
    t.string   "facebook_token"
    t.string   "google_apps_username"
  end

  create_table "what_am_is", force: true do |t|
    t.integer  "correct_user_id"
    t.integer  "guessed_user_id"
    t.boolean  "answer"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_1_id"
    t.integer  "user_2_id"
    t.integer  "user_3_id"
    t.integer  "user_4_id"
    t.boolean  "played"
  end

  add_index "what_am_is", ["user_id"], name: "index_what_am_is_on_user_id", using: :btree

  create_table "who_am_is", force: true do |t|
    t.integer  "correct_user_id"
    t.integer  "answer"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "user3_id"
    t.integer  "user4_id"
    t.boolean  "played"
  end

  add_index "who_am_is", ["user_id"], name: "index_who_am_is_on_user_id", using: :btree

  create_table "wiki_categories", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.boolean  "deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wiki_categories", ["slug"], name: "index_wiki_categories_on_slug", using: :btree

  create_table "wiki_pages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "wiki_page_id"
    t.string   "slug"
    t.integer  "wiki_category_id"
    t.boolean  "lock"
    t.boolean  "deleted"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "wiki_pages", ["slug"], name: "index_wiki_pages_on_slug", using: :btree
  add_index "wiki_pages", ["user_id"], name: "index_wiki_pages_on_user_id", using: :btree
  add_index "wiki_pages", ["wiki_category_id"], name: "index_wiki_pages_on_wiki_category_id", using: :btree

  create_table "workshops", force: true do |t|
    t.string   "name"
    t.text     "ingress"
    t.text     "body"
    t.integer  "number"
    t.integer  "user_id"
    t.boolean  "published"
    t.boolean  "got_comments"
    t.integer  "rank",                        default: 1, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "workshop_image_file_name"
    t.string   "workshop_image_content_type"
    t.integer  "workshop_image_file_size"
    t.datetime "workshop_image_updated_at"
  end

  add_index "workshops", ["user_id"], name: "index_workshops_on_user_id", using: :btree

end
