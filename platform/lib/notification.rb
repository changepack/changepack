# typed: false
# frozen_string_literal: true

class Notification < ApplicationRecord
  key :ntf

  CHANNELS = %w[email slack].freeze

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
  attribute :channel, :string, array: true, default: ['email']
  attribute :data, :jsonb, default: {}
  attribute :url, :string

  attr_accessor :recipient

  belongs_to :subject, polymorphic: true, optional: true
  belongs_to :account, default: -> { recipient.is_a?(User) ? recipient.account : recipient }
  belongs_to :template, default: -> { Template.find_by(category:, type:) if category.present? && type.present? },
                        class_name: 'Notification::Template',
                        optional: true

  has_many :deliveries, dependent: :destroy
  has_many :users, -> { distinct }, through: :deliveries, source: :recipient, source_type: User.name
  has_many :slack_channels, -> { distinct }, through: :deliveries, source: :recipient, source_type: Hook.name

  validates :category, :type, :title, :body, :summary, :channel, presence: true
  validates :channel, inclusion: { in: CHANNELS }

  normalizes :channel, with: ->(channel) { Array(channel).map(&:downcase) }
  normalizes :category, with: ->(category) { category.squish.downcase }
  normalizes :type, with: ->(type) { type.squish.downcase }
  normalizes :summary, with: ->(summary) { summary.squish }
  normalizes :title, with: ->(title) { title.squish }

  inquirer :category
  inquirer :type

  before_validation on: :create do
    assign_attributes_from_template
  end

  after_create :create_deliveries_from_recipient

  sig { returns T::Array[T.any(Hook, User)] }
  def recipients
    @recipients ||= [slack_recipients, email_recipients].flatten
  end

  private

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

  sig { returns T::Array[User] }
  def create_deliveries_from_recipient
    recipients.each do |recipient|
      channel.each { |channel| deliveries.create!(channel:, recipient:) }
    end
  end

  sig { returns T::Array[Hook] }
  def slack_recipients
    return [] unless channel.include?('slack')

    case recipient
    when Account
      Hook.slack.outgoing.where(account: recipient).to_a
    else
      []
    end
  end

  sig { returns T::Array[User] }
  def email_recipients
    return [] unless channel.include?('email')

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
