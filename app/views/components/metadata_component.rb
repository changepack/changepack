# frozen_string_literal: true

class MetadataComponent < ApplicationComponent
  attribute :changelog, Types::Instance(Changelog)

  def template
    a href:, class: 'text-gray-400 text-sm', data: { turbo_frame: '_top' } do
      published
      author
    end
  end

  def author
    div(class: 'mt-1') { user.name } if user.present?
  end

  def href
    helpers.changelog_path(changelog) if changelog.persisted?
  end

  def published
    date = (changelog.created || Time.current).to_date
    text helpers.l(date, format: :long)
  end

  def new_user
    helpers.current_user if changelog.new_record?
  end

  def user
    @user ||= changelog.user || new_user
  end
end
