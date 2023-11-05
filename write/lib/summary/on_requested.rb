# typed: false
# frozen_string_literal: true

class Summary
  class OnRequested < Handler
    on ::Summary::Requested

    sig { override.returns T.nilable(Post) }
    def run
      Summary.new(newsletter:).save if newsletter.present?
    end

    sig { returns T.nilable(Newsletter) }
    def newsletter
      Newsletter.find_by(id: event.newsletter_id)
    end
  end
end
