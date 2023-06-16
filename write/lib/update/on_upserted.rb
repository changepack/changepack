# typed: false
# frozen_string_literal: true

class Update
  class OnUpserted < Handler
    on Update::Upserted

    sig { override.returns T::Boolean }
    def run
      update = Update.find_by(id: event.id)
      return false if silence?(update)

      context = Sydney.new(update:).context
      update.update!(context:)
    end

    private

    sig { params(update: T.nilable(Update)).returns(T::Boolean) }
    def silence?(update)
      update.blank? || update.discarded? || update.context.present? || update.issue.blank?
    end
  end
end
