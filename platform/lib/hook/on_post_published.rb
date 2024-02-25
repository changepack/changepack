# typed: false
# frozen_string_literal: true

class Hook
  class OnPostPublished < Handler
    on ::Post::Published

    sig { override.returns T.nilable(Notification) }
    def run
      return if account.blank?

      Notification.create!(
        body: event.content,
        recipient: account,
        category: :write,
        channel: :slack,
        type: :summary
      )
    end

    private

    def account
      @account ||= Account.find_by(id: event.account_id)
    end
  end
end
