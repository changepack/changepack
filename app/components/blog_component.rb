# frozen_string_literal: true

class BlogComponent < ApplicationComponent
  option :account

  def before_render
    @pagy, @changelogs = pagy(
      account.changelogs
             .includes(:user)
             .order(created_at: :desc)
             .with_rich_text_content
    )
  end
end
