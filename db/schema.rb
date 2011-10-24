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

ActiveRecord::Schema.define(:version => 20111024125941) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.string   "instructor"
    t.string   "room"
    t.string   "day"
    t.string   "units"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "limitations"
    t.string   "address"
    t.string   "end_time"
    t.string   "start_time"
    t.string   "crn"
    t.string   "term_code"
    t.text     "evals"
    t.boolean  "paper_required"
    t.string   "exam_type"
    t.string   "paper_type"
    t.string   "past_instructors"
    t.string   "past_semesters"
    t.string   "tod"
    t.boolean  "in_cart",            :default => false
    t.integer  "day_num"
    t.integer  "time_num"
    t.string   "units_alt"
    t.text     "descrip"
    t.float    "instructor_quality"
    t.float    "classtime_value"
    t.float    "workload"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "course_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   :default => 1
  end

  create_table "searches", :force => true do |t|
    t.string   "day"
    t.string   "units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "instructor"
    t.string   "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
