# frozen_string_literal: true

json.extract! changelog, :id, :title, :created, :updated, :status
json.content changelog.content.body.to_plain_text
json.url changelog_url(changelog, format: :json)
