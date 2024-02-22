# typed: false
# frozen_string_literal: true

class Notification < ApplicationRecord
  key :ntf

  CHANNELS = %w[email].freeze

  # Categories are used to group notifications together, like `user`
  attribute :category, :string
  # Types are used to determine a notification's subcategory, like `welcome`.
  # Together, the category and type determine the template's full path, like
  # `user/welcome`.
  attribute :type, :string
  attribute :title, :string
  attribute :body, :string
  # Summaries are used to generate a preview of the notification
  attribute :summary, :string
  attribute :channel, :string, array: true, default: CHANNELS
  attribute :data, :jsonb, default: {}
  attribute :url, :string

  attr_accessor :recipient

  belongs_to :account
  belongs_to :subject, polymorphic: true, optional: true
  belongs_to :template, class_name: 'Notification::Template', optional: true

  has_many :deliveries, dependent: :destroy
  has_many :users, -> { distinct }, through: :deliveries

  validates :category, :type, :title, :body, :summary, :channel, presence: true
  validates :channel, inclusion: { in: CHANNELS }

  normalizes :channel, with: ->(channel) { Array(channel).map(&:downcase) }

  inquirer :category
  inquirer :type

  before_validation on: :create do
    assign_template
    assign_account_from_recipient
    assign_attributes_from_template
  end

  after_create :create_deliveries_from_recipient

  private

  sig { returns T.nilable(Notification::Template) }
  def assign_template
    return if category.blank? || type.blank?

    self.template ||= Notification::Template.find_by(category:, type:)
  end

  sig { returns Notification }
  def assign_attributes_from_template # rubocop:disable Metrics/AbcSize
    return self unless template

    self.category ||= template.category
    self.type ||= template.type

    self.body ||= template.body
    self.title ||= template.title
    self.summary ||= template.summary

    self
  end

  def assign_account_from_recipient
    self.account ||= recipient.account if recipient.is_a?(User)
    self.account ||= recipient if recipient.is_a?(Account)
  end

  sig { returns T::Array[User] }
  def create_deliveries_from_recipient
    recipients.each do |recipient|
      channel.each do |channel|
        deliveries.create!(channel:, user: recipient)
      end
    end
  end

  sig { returns T::Array[User] }
  def recipients
    case recipient
    when User
      [recipient]
    when Account
      recipient.users.to_a
    else
      []
    end
  end
end