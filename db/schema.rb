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

ActiveRecord::Schema.define(:version => 20111012191544) do

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_log_people", ["user_id"], :name => "index_contact_log_people_on_user_id"

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
    t.integer "id",             :default => 0, :null => false
    t.string  "title_en"
    t.string  "title_no"
    t.integer "user_id"
    t.text    "description_en"
    t.text    "description_no"
    t.string  "group_dn"
    t.integer "admission_id"
    t.integer "group_id"
    t.integer "number",         :default => 1, :null => false
  end

  create_table "positions_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "position_id", :null => false
  end

  create_table "roles", :id => false, :force => true do |t|
    t.integer  "id",         :default => 0, :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "role_id",                   :null => false
    t.integer  "user_id",    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

end
