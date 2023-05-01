# typed: false
# frozen_string_literal: true

class Post
  module Publish
    extend ActiveSupport::Concern
    extend T::Sig

    Updates = T.type_alias { T::Array[String] }

    included do
      after_commit :detach, on: :update, if: :discarded_at_previously_changed?
    end

    sig { params(publishable: T::Boolean).returns(T::Boolean) }
    def publish(publishable)
      if publishable.present? && can_transition_to?(:published)
        transition_to!(:published)
      elsif publishable.blank? && can_transition_to?(:draft)
        transition_to!(:draft)
      end

      false
    end

    sig { params(updates: Updates).void }
    def attach(updates)
      account.updates
             .where(id: updates)
             .find_each { |update| update.update!(post: self) }
    end

    sig { params(except: Updates).void }
    def detach(except: [])
      updates.where.not(id: except)
             .find_each { |update| update.update!(post_id: nil) }
    end
  end
end
