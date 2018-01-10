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

ActiveRecord::Schema.define(version: 20180110082338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_versions", force: true do |t|
    t.integer  "member_id"
    t.integer  "account_id"
    t.integer  "reason"
    t.decimal  "balance",         precision: 32, scale: 16
    t.decimal  "locked",          precision: 32, scale: 16
    t.decimal  "fee",             precision: 32, scale: 16
    t.decimal  "amount",          precision: 32, scale: 16
    t.integer  "modifiable_id"
    t.string   "modifiable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency"
    t.integer  "fun"
  end

  add_index "account_versions", ["account_id", "reason"], name: "index_account_versions_on_account_id_and_reason", using: :btree
  add_index "account_versions", ["account_id"], name: "index_account_versions_on_account_id", using: :btree
  add_index "account_versions", ["member_id", "reason"], name: "index_account_versions_on_member_id_and_reason", using: :btree
  add_index "account_versions", ["modifiable_id", "modifiable_type"], name: "index_account_versions_on_modifiable_id_and_modifiable_type", using: :btree

  create_table "accounts", force: true do |t|
    t.integer  "member_id"
    t.integer  "currency"
    t.decimal  "balance",                         precision: 32, scale: 16
    t.decimal  "locked",                          precision: 32, scale: 16
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "in",                              precision: 32, scale: 16
    t.decimal  "out",                             precision: 32, scale: 16
    t.integer  "default_withdraw_fund_source_id"
  end

  add_index "accounts", ["member_id", "currency"], name: "index_accounts_on_member_id_and_currency", using: :btree
  add_index "accounts", ["member_id"], name: "index_accounts_on_member_id", using: :btree

  create_table "api_tokens", force: true do |t|
    t.integer  "member_id",                        null: false
    t.string   "access_key",            limit: 50, null: false
    t.string   "secret_key",            limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trusted_ip_list"
    t.string   "label"
    t.integer  "oauth_access_token_id"
    t.datetime "expire_at"
    t.string   "scopes"
    t.datetime "deleted_at"
  end

  add_index "api_tokens", ["access_key"], name: "index_api_tokens_on_access_key", unique: true, using: :btree
  add_index "api_tokens", ["secret_key"], name: "index_api_tokens_on_secret_key", unique: true, using: :btree

  create_table "assets", force: true do |t|
    t.string  "type"
    t.integer "attachable_id"
    t.string  "attachable_type"
    t.string  "file"
  end

  create_table "audit_logs", force: true do |t|
    t.string   "type"
    t.integer  "operator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.string   "source_state"
    t.string   "target_state"
  end

  add_index "audit_logs", ["auditable_id", "auditable_type"], name: "index_audit_logs_on_auditable_id_and_auditable_type", using: :btree
  add_index "audit_logs", ["operator_id"], name: "index_audit_logs_on_operator_id", using: :btree

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
  end

  add_index "authentications", ["member_id"], name: "index_authentications_on_member_id", using: :btree
  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "author_id"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_translations", force: true do |t|
    t.integer  "document_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.text     "desc"
    t.text     "keywords"
  end

  add_index "document_translations", ["document_id"], name: "index_document_translations_on_document_id", using: :btree
  add_index "document_translations", ["locale"], name: "index_document_translations_on_locale", using: :btree

  create_table "documents", force: true do |t|
    t.string   "key"
    t.string   "title"
    t.text     "body"
    t.boolean  "is_auth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "desc"
    t.text     "keywords"
  end

  create_table "id_documents", force: true do |t|
    t.integer  "id_document_type"
    t.string   "name"
    t.string   "id_document_number"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birth_date"
    t.text     "address"
    t.string   "city"
    t.string   "country"
    t.string   "zipcode"
    t.integer  "id_bill_type"
    t.string   "aasm_state"
  end

  create_table "identities", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_active"
    t.integer  "retry_count"
    t.boolean  "is_locked"
    t.datetime "locked_at"
    t.datetime "last_verify_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_websites", force: true do |t|
    t.string   "method"
    t.string   "path"
    t.string   "format"
    t.string   "controller"
    t.string   "action"
    t.string   "status"
    t.string   "duration"
    t.string   "view"
    t.string   "db"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "sn"
    t.string   "display_name"
    t.string   "email"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state"
    t.boolean  "activated"
    t.integer  "country_code"
    t.string   "phone_number"
    t.boolean  "disabled",     default: false
    t.boolean  "api_disabled", default: false
    t.string   "nickname"
  end

  create_table "members_roles", id: false, force: true do |t|
    t.integer "member_id"
    t.integer "role_id"
  end

  add_index "members_roles", ["member_id", "role_id"], name: "index_members_roles_on_member_id_and_role_id", using: :btree

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
    t.datetime "deleted_at"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "read_marks", force: true do |t|
    t.integer  "readable_id"
    t.integer  "member_id",                null: false
    t.string   "readable_type", limit: 20, null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["member_id"], name: "index_read_marks_on_member_id", using: :btree
  add_index "read_marks", ["readable_type", "readable_id"], name: "index_read_marks_on_readable_type_and_readable_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "running_accounts", force: true do |t|
    t.integer  "category"
    t.decimal  "income",      precision: 32, scale: 16, default: 0.0, null: false
    t.decimal  "expenses",    precision: 32, scale: 16, default: 0.0, null: false
    t.integer  "currency"
    t.integer  "member_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "running_accounts", ["member_id"], name: "index_running_accounts_on_member_id", using: :btree
  add_index "running_accounts", ["source_id", "source_type"], name: "index_running_accounts_on_source_id_and_source_type", using: :btree

  create_table "signup_histories", force: true do |t|
    t.integer  "member_id"
    t.string   "ip"
    t.string   "accept_language"
    t.string   "ua"
    t.datetime "created_at"
  end

  add_index "signup_histories", ["member_id"], name: "index_signup_histories_on_member_id", using: :btree

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tickets", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "aasm_state"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokens", force: true do |t|
    t.string   "token"
    t.datetime "expire_at"
    t.integer  "member_id"
    t.boolean  "is_used",    default: false
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tokens", ["type", "token", "expire_at", "is_used"], name: "index_tokens_on_type_and_token_and_expire_at_and_is_used", using: :btree

  create_table "trades", force: true do |t|
    t.decimal  "price",         precision: 32, scale: 16
    t.decimal  "volume",        precision: 32, scale: 16
    t.integer  "ask_id"
    t.integer  "bid_id"
    t.integer  "trend"
    t.integer  "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ask_member_id"
    t.integer  "bid_member_id"
    t.decimal  "funds",         precision: 32, scale: 16
  end

  create_table "two_factors", force: true do |t|
    t.integer  "member_id"
    t.string   "otp_secret"
    t.datetime "last_verify_at"
    t.boolean  "activated"
    t.string   "type"
    t.datetime "refreshed_at"
  end

end
