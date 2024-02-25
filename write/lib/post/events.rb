# typed: false
# frozen_string_literal: true

class Post
  module Events
    extend ActiveSupport::Concern
    extend T::Helpers

    abstract!

    class Published < Event
      attribute :id, String
      attribute :content, String
      attribute :account_id, String
    end
  end
end
