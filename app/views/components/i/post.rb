# typed: false
# frozen_string_literal: true

module I
  class Post < ApplicationComponent
    class Metadata < ApplicationComponent
      attribute :post, ::Post

      def template
        wrapper class: 'dimmed text-sm', data: { turbo_frame: '_top' } do
          date
          author
          status
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
        plain helpers.l(created_at.to_date, format: :long)
      end

      def author
        div(class: 'mt-1') { user.name } if user.present?
      end

      def status
        case post.status
        when 'draft'
          div class: 'mt-3' do
            tag { 'Draft' }
          end
        end
      end

      def created_at
        post.published_at || post.created_at || Time.current
      end

      def user
        @user ||= if post.new_record?
                    Current.user
                  else
                    post.user
                  end
      end
    end

    attribute :post, ::Post

    def template
      render I::Aside.new do |aside|
        aside.article { body }
        aside.sidebar { render Metadata.new(post:) }
      end
    end

    def body
      title

      article class: 'text-base prose max-w-full' do
        plain post.content.to_s
      end

      actions
    end

    def title
      return if post.title.blank?

      h2 class: title_class, data: { test_id: 'post' } do
        a href: helpers.post_path(post), data: { turbo_frame: '_top' } do
          span data: { test_id: 'post_button' } do
            plain post.title
          end
        end
      end
    end

    def title_class
      'text-2xl font-medium text-gray-900 title-font mb-2'
    end

    def actions
      return if helpers.disallowed_to?(:edit?, post)

      edit!
      destroy!
    end

    def edit!
      a href: edit_path, **edit_attrs do
        icon 'pencil', class: 'mr-2'
        plain 'Edit post'
      end
    end

    def edit_path
      edit_post_path(post)
    end

    def edit_attrs
      {
        class: 'button-2 mt-4 inline-block',
        data: { test_id: 'edit_post' }
      }
    end

    def destroy!
      div class: 'inline-block ml-2' do
        turbo_frame id: "confirm_destroy_#{post.id}" do
          a href: destroy_path, **destroy_attrs do
            icon 'trash', class: 'mr-2'
            plain 'Delete'
          end
        end
      end
    end

    def destroy_path
      confirm_destroy_post_path(post)
    end

    def destroy_attrs
      {
        class: 'button-delete mt-4 inline-block',
        data: { test_id: 'destroy_post' }
      }
    end
  end
end
