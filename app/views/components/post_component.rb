# typed: false
# frozen_string_literal: true

class PostComponent < ApplicationComponent
  attribute :post, T::Post

  def template
    render ContentComponent.new do |content|
      content.article { body }
      content.sidebar { render MetadataComponent.new(post:) }
    end
  end

  def body
    title

    article class: 'leading-relaxed prose max-w-full' do
      text post.content.to_s
    end

    actions
  end

  def title
    return if post.title.blank?

    h2 class: title_class, data: { test_id: 'post' } do
      a href: post_path(post), data: { turbo_frame: '_top' } do
        span data: { test_id: 'post_button' } do
          text post.title
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
      text 'Edit post'
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
          text 'Delete'
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