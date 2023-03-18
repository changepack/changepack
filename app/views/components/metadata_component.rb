# typed: false
# frozen_string_literal: true

class MetadataComponent < ApplicationComponent
  attribute :changelog, Types::Instance(Changelog)

  def template
    wrapper class: 'dimmed text-sm', data: { turbo_frame: '_top' } do
      published_at
      author
      draft
    end
  end

  def wrapper(**attributes, &)
    if changelog.persisted?
      a href: helpers.changelog_path(changelog), **attributes, &
    else
      div(**attributes, &)
    end
  end

  def draft
    return if changelog.status.published?

    div class: 'mt-4' do
      span class: 'tag' do
        text 'Draft'
      end
    end
  end

  def author
    user.present? && div(class: 'mt-1') { user.name }
  end

  def published_at
    text helpers.l(created_at.to_date, format: :long)
  end

  def created_at
    changelog.created_at || Time.current
  end

  def user
    @user ||= changelog.user || helpers.current_user
  end
end
