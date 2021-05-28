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


ActiveRecord::Schema.define(version: 2021_05_27_103305) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer "step_conversion"
    t.integer "max_contribution"
    t.bigint "charity_event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "enterprise_id", null: false
    t.index ["charity_event_id"], name: "index_campaigns_on_charity_event_id"
    t.index ["enterprise_id"], name: "index_campaigns_on_enterprise_id"
  end

  create_table "charity_events", force: :cascade do |t|
    t.string "title"
    t.string "charity_name"
    t.date "date_beginning"
    t.date "date_ending"
    t.integer "total_donation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
  end

  create_table "donation_payments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "charity_event_id", null: false
    t.string "state"
    t.integer "amount_cents", default: 0, null: false
    t.string "checkout_session"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["charity_event_id"], name: "index_donation_payments_on_charity_event_id"
    t.index ["user_id"], name: "index_donation_payments_on_user_id"
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "joined_campaigns", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "user_donation_event"
    t.float "conversion_enterprise_donation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_joined_campaigns_on_user_id"
  end

  create_table "joined_teams", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_joined_teams_on_team_id"
    t.index ["user_id"], name: "index_joined_teams_on_user_id"
  end

  create_table "steps", force: :cascade do |t|
    t.date "date"
    t.integer "nb_steps"
    t.integer "week"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_steps_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "campaign_id", null: false
    t.index ["campaign_id"], name: "index_teams_on_campaign_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "enterprise_id"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "address"
    t.string "nickname"
    t.string "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["enterprise_id"], name: "index_users_on_enterprise_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "campaigns", "charity_events"
  add_foreign_key "campaigns", "enterprises"
  add_foreign_key "donation_payments", "charity_events"
  add_foreign_key "donation_payments", "users"
  add_foreign_key "joined_campaigns", "users"
  add_foreign_key "joined_teams", "teams"
  add_foreign_key "joined_teams", "users"
  add_foreign_key "steps", "users"
  add_foreign_key "teams", "campaigns"
  add_foreign_key "users", "enterprises"
end
