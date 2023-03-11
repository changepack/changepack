# frozen_string_literal: true

class BlogComponent < ApplicationComponent
  attribute :changelogs, Types.Relation(Changelog)
  attribute :account, Types::Instance(Account)

  attr_reader :pagy, :collection

  def before_template
    @pagy, @collection = paginate!
    super
  end

  def template
    div class: 'block md:flex md:justify-between md:items-center' do
      section(class: 'w-2/3') { title }
      compose!
    end

    posts
    pagination
  end

  def title
    a href: account_path(account) do
      h1(class: 'font-bold text-4xl') { text 'Changelog' }
      h2(class: 'mt-3') { title_text }
      account.description? && div(class: 'mt-1 text-sm dimmed') { text account.description }
    end
  end

  def title_text
    text 'New updates and improvements'

    return if account.name.blank?

    whitespace
    text "to #{account.name}"
  end

  def compose!
    return if helpers.disallowed_to?(:create?, with: ChangelogPolicy)

    div class: 'mt-4 md:mt-0' do
      a href: new_changelog_path, class: 'button-1', data: { test_id: 'new_changelog_button' } do
        icon 'plus', class: 'mr-2'
        text 'Compose'
      end
    end
  end

  def posts
    section class: 'overflow-hidden', id: 'changelogs' do
      div class: 'py-10 md:py-24' do
        div class: '-my-8 divide-y-2 divide-gray-100' do
          render collection if collection.present?
        end
      end
    end
  end

  def pagination
    unsafe_raw helpers.pagy_nav(pagy).to_s if pagy.pages > 1
  end

  def paginate!
    if changelogs.is_a?(Array)
      helpers.pagy_array(changelogs)
    else
      helpers.pagy(changelogs)
    end
  end
end
