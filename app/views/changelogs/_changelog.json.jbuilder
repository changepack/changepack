# frozen_string_literal: true

json.extract! changelog, :id, :title, :body, :created_at, :updated_at
json.url changelog_url(changelog, format: :json)
