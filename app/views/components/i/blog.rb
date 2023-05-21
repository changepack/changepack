# typed: false
# frozen_string_literal: true

module I
  class Blog < ApplicationComponent
    # You can pass a post or a collection of posts
    attribute :posts, T.nilable(T::Posts)
    attribute :post, T.nilable(::Post)
    # If not present, account will be inferred from the post
    attribute :account, T.nilable(Account)

    attr_reader :pagy, :collection

    def before_template
      instance_variable_set(:@account, post.account) if account.nil?
      instance_variable_set(:@posts, [post].compact) if posts.nil?

      @pagy, @collection = paginate!
      super
    end

    def template
      div class: 'block md:flex md:justify-between md:items-center' do
        section do
          title
        end
      end

      content
      pagination
    end

    def title
      a href: account_path(account) do
        h1 class: 'font-semibold text-5xl' do
          plain 'Changelog'
        end

        h2 class: 'mt-8 dimmed text-md md:text-lg' do
          description
        end
      end
    end

    def description
      return account.description if account.description?

      plain 'New updates and improvements'

      return if account.name.blank?

      whitespace
      plain "to #{account.name}"
    end

    def content
      section class: 'overflow-hidden', id: 'posts' do
        div class: 'py-12 md:py-32' do
          div class: '-my-8 divide-y-2 divide-gray-100' do
            collection.each { |post| article(post) }
          end
        end
      end
    end

    def article(post)
      super() do
        turbo_frame id: helpers.dom_id(post) do
          render I::Post.new(post:)
        end
      end
    end

    def pagination
      unsafe_raw helpers.pagy_nav(pagy).to_s if pagy.pages > 1
    end

    def paginate!
      if posts.is_a?(Array)
        helpers.pagy_array(posts)
      else
        helpers.pagy(posts)
      end
    end
  end
end
