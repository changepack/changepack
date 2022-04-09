# frozen_string_literal: true

class BlogComponent < ApplicationComponent
  option :account

  def before_render
    @pagy, @changelogs = pagy(
      account.changelogs
             .for(current_user)
             .includes(:user)
             .order(created_at: :desc)
             .with_rich_text_content_and_embeds
    )
  end
end
