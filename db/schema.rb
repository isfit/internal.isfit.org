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

ActiveRecord::Schema.define(:version => 20120820194049) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.integer  "section_id"
    t.integer  "account_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["section_id"], :name => "index_accounts_on_section_id"

  create_table "applicants", :id => false, :force => true do |t|
    t.integer  "id",                                :default => 0,     :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mail"
    t.integer  "phone"
    t.text     "information"
    t.text     "background"
    t.text     "heardof"
    t.integer  "position_id_1",                                        :null => false
    t.integer  "position_id_2"
    t.integer  "position_id_3"
    t.integer  "status",                            :default => 0
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
    t.boolean  "deleted",                           :default => false, :null => false
    t.string   "username"
    t.string   "password",           :limit => 16
    t.string   "dn",                 :limit => 512
    t.integer  "has_account",        :limit => 1,   :default => 0,     :null => false
    t.integer  "is_notified",                       :default => 0,     :null => false
    t.text     "comment"
  end

  create_table "articles", :force => true do |t|
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
  end

  create_table "contact_log_people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_log_unit_id"
    t.text     "role"
    t.integer  "contact_log_status_id"
  end

  create_table "contact_log_statuses", :force => true do |t|
    t.string   "status"
    t.string   "color_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contact_log_units", :force => true do |t|
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_log_status_id"
  end

  create_table "contact_logs", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "contact_log_person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :id => false, :force => true do |t|
    t.integer "id",                     :default => 0, :null => false
    t.string  "name",                                  :null => false
    t.integer "region_id",                             :null => false
    t.string  "code",      :limit => 4,                :null => false
  end

  create_table "dialogue_participants", :force => true do |t|
    t.datetime "registered_time",                                            :null => false
    t.string   "first_name",                                                 :null => false
    t.string   "middle_name",              :limit => 64
    t.string   "last_name",                                                  :null => false
    t.string   "address1",                                :default => "",    :null => false
    t.string   "address2"
    t.string   "zipcode",                  :limit => 10,  :default => "",    :null => false
    t.string   "city",                                    :default => "",    :null => false
    t.integer  "country_id",                              :default => 0,     :null => false
    t.string   "phone",                    :limit => 20,  :default => "",    :null => false
    t.string   "email",                    :limit => 100, :default => "",    :null => false
    t.string   "fax",                      :limit => 20
    t.string   "nationality",                             :default => "",    :null => false
    t.string   "passport",                                :default => "",    :null => false
    t.date     "birthdate",                                                  :null => false
    t.string   "sex",                      :limit => 2,   :default => "",    :null => false
    t.string   "university",                              :default => "",    :null => false
    t.string   "field_of_study",                                             :null => false
    t.string   "org_name"
    t.string   "org_function"
    t.string   "hear_about_isfit"
    t.string   "hear_about_isfit_other"
    t.text     "essay1",                                                     :null => false
    t.text     "essay2",                                                     :null => false
    t.text     "essay3",                                                     :null => false
    t.text     "essay4",                                                     :null => false
    t.integer  "travel_apply",             :limit => 1,   :default => 0
    t.text     "travel_essay"
    t.string   "travel_amount",            :limit => 20
    t.integer  "travel_nosupport_other",   :limit => 1,   :default => 0
    t.integer  "travel_nosupport_cancome", :limit => 1,   :default => 0
    t.integer  "apply_workshop",           :limit => 1,   :default => 0
    t.integer  "invited",                  :limit => 1,   :default => 0,     :null => false
    t.string   "password"
    t.datetime "last_login"
    t.boolean  "notified_invited",                        :default => false, :null => false
    t.boolean  "notified_rejected",                       :default => false, :null => false
  end

  add_index "dialogue_participants", ["email"], :name => "email", :unique => true

  create_table "festivals", :id => false, :force => true do |t|
    t.integer "id",   :default => 0, :null => false
    t.integer "year"
  end

  create_table "frontend_articles", :force => true do |t|
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
    t.integer  "press_release",                       :limit => 1
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
    t.boolean  "got_comments"
    t.string   "frontend_article_image_file_name"
    t.string   "frontend_article_image_content_type"
    t.integer  "frontend_article_image_file_size"
    t.datetime "frontend_article_image_updated_at"
  end

  create_table "gallery_albums", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gallery_albums", ["user_id"], :name => "index_gallery_albums_on_user_id"

  create_table "gallery_photos", :force => true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "gallery_album_id"
  end

  add_index "gallery_photos", ["user_id"], :name => "index_gallery_photos_on_user_id"

  create_table "groups", :id => false, :force => true do |t|
    t.integer "id",                             :default => 0, :null => false
    t.string  "name_en"
    t.string  "name_no"
    t.integer "section_id"
    t.integer "festival_id"
    t.string  "email",          :limit => 1000
    t.string  "tag",                                           :null => false
    t.text    "description_en"
    t.text    "description_no"
  end

  create_table "groups_positions", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "position_id"
  end

  create_table "internal_tabs", :force => true do |t|
    t.string   "title"
    t.string   "tag"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "action_id"
  end

  add_index "internal_tabs", ["ancestry"], :name => "index_internal_tabs_on_ancestry"

  create_table "isfit_pages", :force => true do |t|
    t.string  "title_en"
    t.string  "title_no"
    t.text    "ingress_en"
    t.text    "ingress_no"
    t.text    "body_en"
    t.text    "body_no"
    t.string  "tag"
    t.boolean "deleted",    :default => false
  end

  create_table "kvitters", :force => true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "new_frontend_articles", :force => true do |t|
    t.string   "title_en"
    t.string   "title_no"
    t.text     "ingress_en"
    t.text     "ingress_no"
    t.text     "body_en"
    t.text     "body_no"
    t.integer  "weight"
    t.boolean  "deleted"
    t.string   "sub_title_no"
    t.string   "sub_title_en"
    t.string   "byline"
    t.integer  "byline_user_id"
    t.boolean  "mail_sent"
    t.datetime "show_article"
    t.boolean  "got_comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "list"
    t.string   "image_text_no"
    t.string   "image_text_en"
    t.boolean  "published"
    t.string   "image_credits"
    t.boolean  "press_release"
  end

  create_table "pads", :force => true do |t|
    t.string   "hexid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.datetime "registered_time",                                              :null => false
    t.datetime "checked_in"
    t.datetime "picked_up"
    t.string   "first_name",                                                   :null => false
    t.string   "middle_name",                :limit => 64
    t.string   "last_name",                                                    :null => false
    t.string   "address1",                                  :default => "",    :null => false
    t.string   "address2"
    t.string   "zipcode",                    :limit => 10,  :default => "",    :null => false
    t.string   "city",                                      :default => "",    :null => false
    t.integer  "country_id",                                :default => 0,     :null => false
    t.string   "phone",                      :limit => 64,                     :null => false
    t.string   "email",                      :limit => 100, :default => "",    :null => false
    t.string   "fax",                        :limit => 20
    t.string   "nationality",                               :default => "",    :null => false
    t.date     "birthdate",                                                    :null => false
    t.string   "sex",                        :limit => 2,   :default => "",    :null => false
    t.string   "university",                                :default => "",    :null => false
    t.string   "field_of_study",                                               :null => false
    t.string   "org_name"
    t.string   "org_function"
    t.string   "hear_about_isfit"
    t.string   "hear_about_isfit_other"
    t.integer  "workshop1",                                 :default => 0,     :null => false
    t.integer  "workshop2",                                 :default => 0,     :null => false
    t.integer  "workshop3",                                 :default => 0,     :null => false
    t.text     "essay1",                                                       :null => false
    t.text     "essay2",                                                       :null => false
    t.integer  "travel_apply",               :limit => 1,   :default => 0
    t.text     "travel_essay"
    t.string   "travel_amount",              :limit => 20
    t.integer  "travel_nosupport_other",     :limit => 1,   :default => 0
    t.integer  "travel_nosupport_cancome",   :limit => 1,   :default => 0
    t.integer  "participant_grade",          :limit => 1,   :default => 0,     :null => false
    t.text     "participant_comment"
    t.integer  "participant_functionary_id",                :default => 0,     :null => false
    t.integer  "theme_grade1",               :limit => 1,   :default => 1,     :null => false
    t.integer  "theme_grade2",               :limit => 1,   :default => 1,     :null => false
    t.text     "theme_comment"
    t.text     "theme_comment_2"
    t.integer  "theme_functionary_id_2",                    :default => 0
    t.integer  "theme_functionary_id",                      :default => 0,     :null => false
    t.string   "password"
    t.integer  "final_workshop",                            :default => 0,     :null => false
    t.integer  "invited",                    :limit => 1,   :default => 0,     :null => false
    t.integer  "travel_assigned",            :limit => 1,   :default => 0,     :null => false
    t.integer  "travel_assigned_amount",                    :default => 0,     :null => false
    t.text     "travel_comment"
    t.integer  "host_id"
    t.datetime "last_login"
    t.boolean  "notified_invitation",                       :default => false, :null => false
    t.boolean  "notified_travel_support",                   :default => false, :null => false
    t.boolean  "notified_rejection",                        :default => false, :null => false
    t.boolean  "notified_no_travel_support",                :default => false, :null => false
    t.boolean  "notified_rejection_again",                  :default => false, :null => false
    t.date     "arrival_date"
    t.string   "arrival_place",              :limit => 100
    t.time     "arrival_time"
    t.string   "arrival_carrier",            :limit => 5
    t.boolean  "arrival_isfit_trans"
    t.string   "arrival_airline",            :limit => 30
    t.string   "arrival_flight_number",      :limit => 10
    t.date     "departure_date"
    t.time     "departure_time"
    t.string   "departure_carrier",          :limit => 5
    t.boolean  "departure_isfit_trans"
    t.string   "departure_place",            :limit => 100
    t.boolean  "notified_custom",                           :default => false, :null => false
    t.boolean  "blocked",                                   :default => false, :null => false
    t.datetime "request_travel"
    t.integer  "accept_travel",              :limit => 1
    t.datetime "accept_travel_time"
    t.integer  "bed",                        :limit => 1,   :default => 0,     :null => false
    t.integer  "bedding",                    :limit => 1,   :default => 0,     :null => false
    t.boolean  "special_invite",                            :default => false, :null => false
    t.boolean  "deleted",                                   :default => false
  end

  add_index "participants", ["email"], :name => "email", :unique => true

  create_table "photos", :force => true do |t|
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

  create_table "positions", :id => false, :force => true do |t|
    t.integer  "id",             :default => 0, :null => false
    t.string   "title_en"
    t.string   "title_no"
    t.integer  "user_id"
    t.text     "description_en"
    t.text     "description_no"
    t.string   "group_dn"
    t.integer  "admission_id"
    t.integer  "group_id"
    t.integer  "number",         :default => 1, :null => false
    t.datetime "publish_from"
    t.datetime "publish_to"
  end

  create_table "positions_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "position_id", :null => false
  end

  create_table "presentations", :force => true do |t|
    t.string   "title"
    t.text     "markdown_text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "presentations", ["user_id"], :name => "index_presentations_on_user_id"

  create_table "roles", :id => false, :force => true do |t|
    t.integer  "id",         :default => 0, :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "role_id",    :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_bookings", :force => true do |t|
    t.datetime "reserved_at"
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sections", :id => false, :force => true do |t|
    t.integer "id",                             :default => 0, :null => false
    t.string  "name_en"
    t.string  "name_no"
    t.integer "festival_id"
    t.string  "email",          :limit => 1000
    t.string  "tag",                                           :null => false
    t.text    "description_en"
    t.text    "description_no"
  end

  create_table "spp_articles", :force => true do |t|
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

  create_table "spp_pages", :force => true do |t|
    t.string   "title_en"
    t.string   "ingress_en"
    t.text     "body_en"
    t.string   "image_text"
    t.integer  "byline_func_id"
    t.string   "byline"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "title_no"
    t.text     "body_no"
    t.text     "ingress_no"
  end

  create_table "static_pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "static_pages", ["user_id"], :name => "index_static_pages_on_user_id"

  create_table "users", :id => false, :force => true do |t|
    t.integer  "id",                                        :default => 0, :null => false
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
    t.integer  "vegetarian",                   :limit => 1
    t.integer  "lactose_allergy",              :limit => 1
    t.integer  "gluten_allergy",               :limit => 1
    t.integer  "nut_allergy",                  :limit => 1
    t.integer  "fruit_allergy",                :limit => 1
    t.text     "other_allergy"
    t.integer  "no_allergy",                   :limit => 1
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_username"
    t.string   "facebook_id"
    t.string   "facebook_token"
  end

  create_table "what_am_is", :force => true do |t|
    t.integer  "correct_user_id"
    t.integer  "guessed_user_id"
    t.boolean  "answer"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_1_id"
    t.integer  "user_2_id"
    t.integer  "user_3_id"
    t.integer  "user_4_id"
    t.boolean  "played"
  end

  add_index "what_am_is", ["user_id"], :name => "index_what_am_is_on_user_id"

  create_table "who_am_is", :force => true do |t|
    t.integer  "correct_user_id"
    t.boolean  "answer"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "user3_id"
    t.integer  "user4_id"
    t.boolean  "played"
  end

  add_index "who_am_is", ["user_id"], :name => "index_who_am_is_on_user_id"

  create_table "wiki_categories", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.boolean  "deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wiki_categories", ["slug"], :name => "index_wiki_categories_on_slug"

  create_table "wiki_pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "wiki_page_id"
    t.string   "slug"
    t.integer  "wiki_category_id"
    t.boolean  "lock"
    t.boolean  "deleted"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "wiki_pages", ["slug"], :name => "index_wiki_pages_on_slug"
  add_index "wiki_pages", ["user_id"], :name => "index_wiki_pages_on_user_id"
  add_index "wiki_pages", ["wiki_category_id"], :name => "index_wiki_pages_on_wiki_category_id"

  create_table "workshops", :force => true do |t|
    t.string   "name"
    t.text     "ingress"
    t.text     "body"
    t.integer  "number"
    t.integer  "user_id"
    t.boolean  "published"
    t.boolean  "got_comments"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "workshop_image_file_name"
    t.string   "workshop_image_content_type"
    t.integer  "workshop_image_file_size"
    t.datetime "workshop_image_updated_at"
  end

  add_index "workshops", ["user_id"], :name => "index_workshops_on_user_id"

end
