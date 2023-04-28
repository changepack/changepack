# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_28_231551) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", id: :string, force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "token", null: false
    t.string "user_id", null: false
    t.string "account_id", null: false
    t.string "changelog_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "provider", "token"], name: "index_access_tokens_on_account_id_and_provider_and_token", unique: true
    t.index ["account_id"], name: "index_access_tokens_on_account_id"
    t.index ["changelog_id"], name: "index_access_tokens_on_changelog_id"
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "accounts", id: :string, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.datetime "discarded_at"
    t.string "description"
    t.string "website"
    t.index ["discarded_at"], name: "index_accounts_on_discarded_at"
    t.index ["slug"], name: "index_accounts_on_slug", unique: true
  end

  create_table "action_text_rich_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.string "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.string "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "changelogs", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "slug", null: false
    t.string "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_changelogs_on_account_id"
  end

  create_table "commits", id: :string, force: :cascade do |t|
    t.text "message", null: false
    t.string "url", null: false
    t.datetime "commited_at", null: false
    t.jsonb "author", default: {}, null: false
    t.string "account_id", null: false
    t.string "repository_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.jsonb "providers", default: {}, null: false
    t.index ["account_id"], name: "index_commits_on_account_id"
    t.index ["discarded_at"], name: "index_commits_on_discarded_at"
    t.index ["repository_id"], name: "index_commits_on_repository_id"
  end

  create_table "event_store_events", force: :cascade do |t|
    t.uuid "event_id", null: false
    t.string "event_type", null: false
    t.jsonb "metadata"
    t.jsonb "data", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "valid_at", precision: nil
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
    t.index ["event_id"], name: "index_event_store_events_on_event_id", unique: true
    t.index ["event_type"], name: "index_event_store_events_on_event_type"
    t.index ["valid_at"], name: "index_event_store_events_on_valid_at"
  end

  create_table "event_store_events_in_streams", force: :cascade do |t|
    t.string "stream", null: false
    t.integer "position"
    t.uuid "event_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["created_at"], name: "index_event_store_events_in_streams_on_created_at"
    t.index ["stream", "event_id"], name: "index_event_store_events_in_streams_on_stream_and_event_id", unique: true
    t.index ["stream", "position"], name: "index_event_store_events_in_streams_on_stream_and_position", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "post_transitions", id: :string, force: :cascade do |t|
    t.string "to_state", null: false
    t.jsonb "metadata", default: {}
    t.integer "sort_key", null: false
    t.string "post_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id", "most_recent"], name: "index_changelog_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["post_id", "sort_key"], name: "index_changelog_transitions_parent_sort", unique: true
  end

  create_table "posts", id: :string, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "draft", null: false
    t.string "user_id"
    t.string "account_id", null: false
    t.string "slug"
    t.datetime "discarded_at"
    t.string "changelog_id", null: false
    t.index ["account_id"], name: "index_posts_on_account_id"
    t.index ["changelog_id"], name: "index_posts_on_changelog_id"
    t.index ["discarded_at"], name: "index_posts_on_discarded_at"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "repositories", id: :string, force: :cascade do |t|
    t.string "account_id", null: false
    t.string "name", null: false
    t.string "branch", null: false
    t.string "status", default: "inactive", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "pulled_at"
    t.datetime "discarded_at"
    t.jsonb "providers", default: {}, null: false
    t.index ["account_id"], name: "index_repositories_on_account_id"
    t.index ["discarded_at"], name: "index_repositories_on_discarded_at"
  end

  create_table "repository_transitions", id: :string, force: :cascade do |t|
    t.string "to_state", null: false
    t.jsonb "metadata", default: {}
    t.integer "sort_key", null: false
    t.string "repository_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id", "most_recent"], name: "index_repository_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["repository_id", "sort_key"], name: "index_repository_transitions_parent_sort", unique: true
  end

  create_table "updates", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.string "account_id"
    t.string "commit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "post_id"
    t.datetime "discarded_at"
    t.index ["account_id", "commit_id"], name: "index_updates_on_account_id_and_commit_id", unique: true
    t.index ["account_id"], name: "index_updates_on_account_id"
    t.index ["commit_id"], name: "index_updates_on_commit_id"
    t.index ["post_id"], name: "index_updates_on_post_id"
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_id", null: false
    t.string "name"
    t.jsonb "providers", default: {}
    t.datetime "discarded"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["discarded"], name: "index_users_on_discarded"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.string "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.datetime "created_at"
    t.jsonb "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "access_tokens", "accounts"
  add_foreign_key "access_tokens", "changelogs"
  add_foreign_key "access_tokens", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "changelogs", "accounts"
  add_foreign_key "commits", "accounts"
  add_foreign_key "commits", "repositories"
  add_foreign_key "post_transitions", "posts"
  add_foreign_key "posts", "accounts"
  add_foreign_key "posts", "changelogs"
  add_foreign_key "posts", "users"
  add_foreign_key "repositories", "accounts"
  add_foreign_key "repository_transitions", "repositories"
  add_foreign_key "updates", "accounts"
  add_foreign_key "updates", "commits"
  add_foreign_key "updates", "posts"
  add_foreign_key "users", "accounts"
end
