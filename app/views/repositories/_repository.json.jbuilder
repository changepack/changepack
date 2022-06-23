# frozen_string_literal: true

json.extract! repository, :id, :name, :branch, :status, :created, :updated
json.url repository_url(repository, format: :json)
