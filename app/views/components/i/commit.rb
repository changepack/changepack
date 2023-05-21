# typed: false
# frozen_string_literal: true

module I
  class Commit < ApplicationComponent
    class Message < ApplicationComponent
      attribute :commit, ::Commit
      attribute :url, T.nilable(String)

      def template
        abbr class: 'no-underline', title: commit.message do
          url.present? ? unsafe_raw(link_to) : plain(message)
        end
      end

      def link_to
        helpers.link_to url, target: '_blank', rel: 'noopener', data: { turbo_frame: '_top' } do
          del class: 'dimmed' do
            message
          end
        end
      end

      def message
        commit.message.truncate(50)
      end
    end

    attribute :commit, ::Commit
    attribute :url, T.nilable(String)

    def template
      render Message.new(commit:, url:)

      div class: 'flex items-center mt-1 pl-4' do
        provider
        repository
        author
        commited_at
      end
    end

    def provider
      tag do
        case commit.provider
        when 'github'
          'GitHub'
        end
      end
    end

    def repository
      tag class: 'ml-2' do
        "#{commit.repository.name}@#{commit.repository.branch}"
      end
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
