# frozen_string_literal: true

class ChangelogComponent < ApplicationComponent
  attribute :changelog, Types::Instance(Changelog)

  register_element :turbo_frame

  def template
    render ContentComponent.new do |content|
      content.article { body }
      content.sidebar { render MetadataComponent.new(changelog:) }
    end
  end

  def body
    title
    draft

    article class: 'leading-relaxed prose max-w-full' do
      text changelog.content.to_s
    end

    actions
  end

  def title
    return if changelog.title.blank?

    h2 class: title_class, data: { test_id: 'changelog' } do
      a href: changelog_path(changelog), data: { turbo_frame: '_top' } do
        span data: { test_id: 'changelog_button' } do
          text changelog.title
        end
      end
    end
  end

  def title_class
    'text-2xl font-medium text-gray-900 title-font mb-2'
  end

  def draft
    return if changelog.status.published?

    div class: 'mb-2 -mt-1 -ml-1' do
      span class: 'tag' do
        text 'Draft'
      end
    end
  end

  def actions
    return if helpers.disallowed_to?(:edit?, changelog)

    edit!
    destroy!
  end

  def edit!
    a href: edit_path, **edit_attrs do
      icon 'pencil', class: 'mr-2'
      text 'Edit changelog'
    end
  end

  def edit_path
    edit_changelog_path(changelog)
  end

  def edit_attrs
    {
      class: 'button-2 mt-4 inline-block',
      data: { test_id: 'edit_changelog' }
    }
  end

  def destroy!
    div class: 'inline-block ml-2' do
      turbo_frame id: "confirm_destroy_#{changelog.id}" do
        a href: destroy_path, **destroy_attrs do
          icon 'trash', class: 'mr-2'
          text 'Delete'
        end
      end
    end
  end

  def destroy_path
    confirm_destroy_changelog_path(changelog)
  end

  def destroy_attrs
    {
      class: 'button-delete mt-4 inline-block',
      data: { test_id: 'destroy_changelog' }
    }
  end
end
