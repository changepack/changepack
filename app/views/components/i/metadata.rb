# typed: false
# frozen_string_literal: true

module I
  class Metadata < ApplicationComponent
    class Date < ApplicationComponent
      attribute :date, T.any(Date, T::Time)

      def template
        plain helpers.l(date.to_date, format: :long)
      end
    end

    class Author < ApplicationComponent
      attribute :user, T::User

      def template
        user.present? && div(class: 'mt-1') { user.name }
      end
    end

    class Draft < ApplicationComponent
      def template
        div class: 'mt-4' do
          span class: 'tag' do
            plain 'Draft'
          end
        end
      end
    end

    attribute :post, T::Post

    def template
      wrapper class: 'dimmed text-sm', data: { turbo_frame: '_top' } do
        render Date.new(date:)
        render Author.new(user:) if user.present?
        render Draft.new if post.draft?
      end
    end

    def wrapper(**attributes, &)
      if post.persisted?
        a href: helpers.post_path(post), **attributes, &
      else
        div(**attributes, &)
      end
    end

    def date
      post.created_at || Time.current
    end

    def user
      @user ||= post.user || helpers.current_user
    end
  end
end
