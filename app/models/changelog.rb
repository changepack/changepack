class Changelog < ApplicationRecord
  key :log

  attribute :title, :string
  attribute :body, :text
end
