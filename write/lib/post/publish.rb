# typed: false
# frozen_string_literal: true

class Post
  module Publish
    extend ActiveSupport::Concern
    extend T::Helpers
    extend T::Sig

    Updates = T.type_alias { T::Array[String] }

    abstract!

    included do
      attribute :published_at, :datetime
      validates :published_at, presence: true, if: :published?

      after_commit :detach, on: :update, if: :discarded_at_previously_changed?
    end

    sig { overridable.params(publishable: T::Boolean).returns(T::Boolean) }
    def publish(publishable)
      if publishable.present? && can_transition_to?(:published)
        transition_to!(:published)
      elsif publishable.blank? && can_transition_to?(:draft)
        transition_to!(:draft)
      end

      false
    end

    sig { overridable.params(updates: Updates).void }
    def attach(updates)
      Update.transaction do
        account.updates
               .where(id: updates)
               .includes(:source)
               .find_each { |update| update.update!(post: self) }
      end
    end

    sig { overridable.params(except: Updates).void }
    def detach(except: [])
      Update.transaction do
        updates.where.not(id: except)
               .includes(:source)
               .find_each { |update| update.update!(post_id: nil) }
      end
    end
  end
end
