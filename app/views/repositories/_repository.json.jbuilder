# frozen_string_literal: true

json.extract! repository, :id, :name, :branch, :status, :created_at, :updated_at
json.url repository_url(repository, format: :json)
