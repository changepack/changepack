# typed: false
# frozen_string_literal: true

module I
  class Commit < ApplicationComponent
    class Message < ApplicationComponent
      attribute :commit, T::Commit
      attribute :post, T.nilable(::Post)

      def template
        abbr class: 'no-underline', title: commit.message do
          link_to? ? unsafe_raw(link_to) : plain(commit.abbr)
        end
      end

      def link_to
        helpers.link_to commit.post, target: '_blank', rel: 'noopener', data: { turbo_frame: '_top' } do
          del class: 'dimmed' do
            commit.abbr
          end
        end
      end

      def link_to?
        post.present? && commit.disabled?(post)
      end
    end

    attribute :commit, T::Commit
    attribute :post, T.nilable(::Post)

    def template
      render Message.new(commit:, post:)

      div class: 'flex items-center mt-1 pl-4' do
        repository
        author
        commited_at
      end
    end

    def repository
      tag { "#{commit.repository.name}@#{commit.repository.branch}" }
    end

    def author
      tag class: 'ml-2' do
        commit.author.name
      end
    end

    def commited_at
      tag class: 'ml-2' do
        helpers.l(commit.commited_at, format: :long)
      end
    end
  end
end
