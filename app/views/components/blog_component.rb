# frozen_string_literal: true

class BlogComponent < ApplicationComponent
  # You can pass a changelog or a collection of changelogs
  attribute :changelogs, Types.Relation(Changelog).optional
  attribute :changelog, Types::Instance(Changelog).optional
  # If not present, account will be inferred from the changelog
  attribute :account, Types::Instance(Account).optional

  attr_reader :pagy, :collection

  def before_template
    instance_variable_set(:@account, changelog.account) if account.nil?
    @pagy, @collection = paginate!
    super
  end

  def template
    div class: 'block md:flex md:justify-between md:items-center' do
      section class: 'md:w-1/2' do
        title
      end

      compose!
    end

    posts
    pagination
  end

  def title
    a href: account_path(account) do
      h1 class: 'font-semibold text-5xl' do
        text 'Changelog'
      end

      h2(class: 'mt-8') do
        title_text
      end

      account.description? && description
    end
  end

  def description
    div class: 'mt-2 text-sm dimmed' do
      text account.description
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
      div class: 'py-12 md:py-32' do
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
    instance_variable_set(:@changelogs, [changelog].compact) if changelogs.nil?

    if changelogs.is_a?(Array)
      helpers.pagy_array(changelogs)
    else
      helpers.pagy(changelogs)
    end
  end
end
