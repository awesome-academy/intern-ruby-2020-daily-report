# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_12_041117) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci", force: :cascade do |t|
    t.bigint "report_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["report_id"], name: "index_comments_on_report_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "divisions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci", force: :cascade do |t|
    t.string "division_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "path"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "today_plan"
    t.text "actual"
    t.text "reason_not_complete"
    t.text "tomorrow_plan"
    t.text "free_comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "type"
    t.date "request_for_date"
    t.time "checked_time"
    t.datetime "compensation_from"
    t.datetime "compensation_to"
    t.text "reason"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role", default: 1
    t.bigint "division_id", default: 1, null: false
    t.string "password_digest"
    t.boolean "activated", default: false
    t.string "reset_digest"
    t.datetime "reset_send_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["division_id"], name: "index_users_on_division_id"
  end

  add_foreign_key "comments", "reports"
  add_foreign_key "comments", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "reports", "users"
  add_foreign_key "requests", "users"
  add_foreign_key "users", "divisions"
end
