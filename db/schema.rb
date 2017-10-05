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

ActiveRecord::Schema.define(version: 20171005095100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "username"
    t.string "uid"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "provider", "uid"], name: "index_authentications_on_user_id_and_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "ticket_id"
    t.integer "user_id"
    t.string "attachment"
    t.integer "attachment_size"
    t.string "attachment_content_type"
    t.string "screenshot"
    t.integer "screenshot_size"
    t.integer "screenshot_width"
    t.integer "screenshot_height"
    t.string "screenshot_content_type"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_system", default: false, null: false
    t.string "commit_hash"
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.boolean "active", default: true, null: false
    t.string "slug"
    t.string "icon"
    t.string "icon_content_type"
    t.integer "icon_size"
    t.integer "icon_width"
    t.integer "icon_height"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "github_user"
    t.string "github_repo"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "screenshots", id: :serial, force: :cascade do |t|
    t.string "image"
    t.integer "image_size"
    t.integer "image_width"
    t.integer "image_height"
    t.string "image_content_type"
    t.integer "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_screenshots_on_ticket_id"
  end

  create_table "tickets", id: :serial, force: :cascade do |t|
    t.integer "tickettype_id"
    t.integer "project_id"
    t.integer "user_id"
    t.string "name"
    t.text "description"
    t.integer "urgency"
    t.date "date_requested"
    t.integer "status"
    t.string "relevant_url"
    t.integer "resolution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "assigned_id", default: 1, null: false
    t.string "attachment"
    t.integer "attachment_size"
    t.string "attachment_content_type"
    t.index ["project_id"], name: "index_tickets_on_project_id"
    t.index ["tickettype_id"], name: "index_tickets_on_tickettype_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "tickettypes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "name"
    t.string "slug"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "avatar_content_type"
    t.integer "avatar_height"
    t.integer "avatar_size"
    t.integer "avatar_width"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users"
  add_foreign_key "screenshots", "tickets"
  add_foreign_key "tickets", "projects"
  add_foreign_key "tickets", "tickettypes"
  add_foreign_key "tickets", "users"
end
