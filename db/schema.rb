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

ActiveRecord::Schema[7.1].define(version: 2024_02_25_174819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", id: :string, force: :cascade do |t|
    t.string "type", null: false
    t.string "token", null: false
    t.string "user_id", null: false
    t.string "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "type", "token"], name: "index_access_tokens_on_account_id_and_type_and_token", unique: true
    t.index ["account_id"], name: "index_access_tokens_on_account_id"
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

  create_table "api_keys", id: :string, force: :cascade do |t|
    t.string "token", null: false
    t.datetime "last_used_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bearer_type"
    t.string "bearer_id"
    t.index ["bearer_type", "bearer_id"], name: "index_api_keys_on_bearer"
    t.index ["token"], name: "index_api_keys_on_token", unique: true
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
    t.index ["providers"], name: "index_commits_on_providers", unique: true
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

  create_table "filters", id: :string, force: :cascade do |t|
    t.string "trait", null: false
    t.string "content", null: false
    t.string "source_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", default: "reject", null: false
    t.index ["source_id", "trait", "content", "type"], name: "index_filters_on_source_id_trait_content_and_type", unique: true
    t.index ["source_id"], name: "index_filters_on_source_id"
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

  create_table "hooks", id: :string, force: :cascade do |t|
    t.string "provider", null: false
    t.string "direction", null: false
    t.jsonb "request", default: {}, null: false
    t.string "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_hooks_on_account_id"
  end

  create_table "issues", id: :string, force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.jsonb "assignee", default: {}
    t.jsonb "providers", default: {}, null: false
    t.string "branch"
    t.string "identifier"
    t.string "labels", default: [], null: false, array: true
    t.decimal "priority"
    t.boolean "done", default: false, null: false
    t.datetime "discarded_at"
    t.string "account_id", null: false
    t.string "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "issued_at", null: false
    t.index ["account_id"], name: "index_issues_on_account_id"
    t.index ["providers"], name: "index_issues_on_providers", unique: true
    t.index ["team_id"], name: "index_issues_on_team_id"
  end

  create_table "newsletters", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "slug", null: false
    t.string "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.string "audience"
    t.index ["account_id"], name: "index_newsletters_on_account_id"
  end

  create_table "notification_deliveries", id: :string, force: :cascade do |t|
    t.string "notification_id", null: false
    t.string "recipient_id", null: false
    t.datetime "queued_at"
    t.datetime "sent_at"
    t.string "channel", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recipient_type"
    t.index ["notification_id"], name: "index_notification_deliveries_on_notification_id"
    t.index ["recipient_id"], name: "index_notification_deliveries_on_recipient_id"
    t.index ["recipient_type", "recipient_id"], name: "idx_on_recipient_type_recipient_id_562ec654b9"
  end

  create_table "notification_templates", id: :string, force: :cascade do |t|
    t.string "category", null: false
    t.string "type", null: false
    t.string "title", null: false
    t.text "body"
    t.string "summary", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "category"], name: "index_notification_templates_on_type_and_category", unique: true
  end

  create_table "notifications", id: :string, force: :cascade do |t|
    t.string "type", null: false
    t.string "channel", default: ["email", "web"], null: false, array: true
    t.string "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category", null: false
    t.string "title", null: false
    t.string "body", null: false
    t.string "summary", null: false
    t.jsonb "data", default: {}, null: false
    t.string "url"
    t.string "subject_type"
    t.bigint "subject_id"
    t.string "template_id"
    t.index ["account_id"], name: "index_notifications_on_account_id"
    t.index ["subject_type", "subject_id"], name: "index_notifications_on_subject"
    t.index ["template_id"], name: "index_notifications_on_template_id"
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
    t.string "newsletter_id", null: false
    t.datetime "published_at"
    t.index ["account_id"], name: "index_posts_on_account_id"
    t.index ["discarded_at"], name: "index_posts_on_discarded_at"
    t.index ["newsletter_id"], name: "index_posts_on_newsletter_id"
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
    t.string "access_token_id"
    t.index ["access_token_id"], name: "index_repositories_on_access_token_id"
    t.index ["account_id"], name: "index_repositories_on_account_id"
    t.index ["discarded_at"], name: "index_repositories_on_discarded_at"
    t.index ["providers"], name: "index_repositories_on_providers", unique: true
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

  create_table "sources", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.string "account_id", null: false
    t.string "repository_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "inactive"
    t.datetime "discarded_at"
    t.string "newsletter_id"
    t.string "team_id"
    t.index ["account_id"], name: "index_sources_on_account_id"
    t.index ["newsletter_id"], name: "index_sources_on_newsletter_id"
    t.index ["repository_id"], name: "index_sources_on_repository_id", unique: true
    t.index ["team_id"], name: "index_sources_on_team_id"
  end

  create_table "team_transitions", id: :string, force: :cascade do |t|
    t.string "to_state", null: false
    t.jsonb "metadata", default: {}
    t.integer "sort_key", null: false
    t.string "team_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id", "most_recent"], name: "index_team_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["team_id", "sort_key"], name: "index_team_transitions_parent_sort", unique: true
  end

  create_table "teams", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "status", default: "inactive", null: false
    t.jsonb "providers", default: {}, null: false
    t.datetime "discarded_at"
    t.string "account_id", null: false
    t.string "access_token_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "pulled_at"
    t.jsonb "schema", default: {}, null: false
    t.index ["access_token_id"], name: "index_teams_on_access_token_id"
    t.index ["account_id"], name: "index_teams_on_account_id"
    t.index ["providers"], name: "index_teams_on_providers", unique: true
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
    t.string "source_id"
    t.string "newsletter_id"
    t.string "issue_id"
    t.string "tags", default: [], null: false, array: true
    t.datetime "sourced_at", null: false
    t.text "description"
    t.index ["account_id", "commit_id"], name: "index_updates_on_account_id_and_commit_id", unique: true
    t.index ["account_id"], name: "index_updates_on_account_id"
    t.index ["commit_id"], name: "index_updates_on_commit_id", unique: true
    t.index ["issue_id"], name: "index_updates_on_issue_id"
    t.index ["newsletter_id"], name: "index_updates_on_newsletter_id"
    t.index ["post_id"], name: "index_updates_on_post_id"
    t.index ["source_id"], name: "index_updates_on_source_id"
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
  add_foreign_key "access_tokens", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "commits", "accounts"
  add_foreign_key "commits", "repositories"
  add_foreign_key "filters", "sources"
  add_foreign_key "hooks", "accounts"
  add_foreign_key "issues", "accounts"
  add_foreign_key "issues", "teams"
  add_foreign_key "newsletters", "accounts"
  add_foreign_key "notification_deliveries", "notifications"
  add_foreign_key "notification_deliveries", "users", column: "recipient_id"
  add_foreign_key "notifications", "accounts"
  add_foreign_key "notifications", "notification_templates", column: "template_id"
  add_foreign_key "post_transitions", "posts"
  add_foreign_key "posts", "accounts"
  add_foreign_key "posts", "newsletters"
  add_foreign_key "posts", "users"
  add_foreign_key "repositories", "access_tokens"
  add_foreign_key "repositories", "accounts"
  add_foreign_key "repository_transitions", "repositories"
  add_foreign_key "sources", "accounts"
  add_foreign_key "sources", "newsletters"
  add_foreign_key "team_transitions", "teams"
  add_foreign_key "teams", "access_tokens"
  add_foreign_key "teams", "accounts"
  add_foreign_key "updates", "accounts"
  add_foreign_key "updates", "newsletters"
  add_foreign_key "updates", "posts"
  add_foreign_key "updates", "sources"
  add_foreign_key "users", "accounts"
end
