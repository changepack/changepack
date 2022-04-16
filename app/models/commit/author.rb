# frozen_string_literal: true

class Commit::Author # rubocop:disable Style/ClassAndModuleChildren
  include StoreModel::Model

  attribute :name, :string
  attribute :email, :string

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
