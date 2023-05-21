# typed: false
# frozen_string_literal: true

module I
  class Issue < ApplicationComponent
    class Title < ApplicationComponent
      attribute :issue, ::Issue
      attribute :url, T.nilable(String)

      def template
        abbr class: 'no-underline', title: issue.title do
          url.present? ? unsafe_raw(link_to) : plain(title)
        end
      end

      def link_to
        helpers.link_to url, target: '_blank', rel: 'noopener', data: { turbo_frame: '_top' } do
          del class: 'dimmed' do
            title
          end
        end
      end

      def title
        issue.title.truncate(50)
      end
    end

    attribute :issue, ::Issue
    attribute :url, T.nilable(String)

    def template
      render Title.new(issue:, url:)

      div class: 'flex items-center mt-1 pl-4' do
        provider
        team
        assignee
        issued_at
      end
    end

    def provider
      tag do
        case issue.provider
        when 'linear'
          'Linear'
        end
      end
    end

    def team
      tag class: 'ml-2' do
        issue.team.name
      end
    end

    def assignee
      return if issue.assignee.blank?

      tag class: 'ml-2' do
        issue.assignee.name
      end
    end

    def issued_at
      tag class: 'ml-2' do
        helpers.l(issue.issued_at, format: :long)
      end
    end
  end
end
