# frozen_string_literal: true

class MetadataComponent < ApplicationComponent
  attribute :changelog, Types::Instance(Changelog)

  def template
    wrapper class: 'dimmed text-sm', data: { turbo_frame: '_top' } do
      published
      author
    end
  end

  def wrapper(**attributes, &)
    if changelog.persisted?
      a(href: helpers.changelog_path(changelog), **attributes, &)
    else
      div(**attributes, &)
    end
  end

  def author
    user.present? && div(class: 'mt-1') { user.name }
  end

  def published
    text helpers.l(created.to_date, format: :long)
  end

  def created
    changelog.created || Time.current
  end

  def user
    @user ||= changelog.user || helpers.current_user
  end
end
