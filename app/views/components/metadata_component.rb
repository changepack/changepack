# typed: false
# frozen_string_literal: true

class MetadataComponent < ApplicationComponent
  attribute :post, T::Post

  def template
    wrapper class: 'dimmed text-sm', data: { turbo_frame: '_top' } do
      published_at
      author
      draft
    end
  end

  def wrapper(**attributes, &)
    if post.persisted?
      a href: helpers.post_path(post), **attributes, &
    else
      div(**attributes, &)
    end
  end

  def draft
    return if post.status.published?

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
    post.created_at || Time.current
  end

  def user
    @user ||= post.user || helpers.current_user
  end
end
