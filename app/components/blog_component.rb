# frozen_string_literal: true

class BlogComponent < ApplicationComponent
  option :account
  option :readonly, optional: true, default: -> { false }

  def before_render
    @pagy, @changelogs = pagy(
      account.changelogs
             .includes(:user)
             .order(created_at: :desc)
             .with_rich_text_content
    )
  end
end
