# typed: false
# frozen_string_literal: true

class Notification
  class Template < ApplicationRecord
    key :ntft

    attribute :category, :string
    attribute :type, :string
    attribute :title, :string
    attribute :body, :string
    attribute :summary, :string

    has_many :notifications, dependent: :nullify

    validates :category, :type, :title, :body, :summary, presence: true
    validates :type, uniqueness: { scope: :category }
  end
end
