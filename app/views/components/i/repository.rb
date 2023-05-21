# typed: false
# frozen_string_literal: true

module I
  class Repository < ApplicationComponent
    attribute :repository, ::Repository

    def template
      wrapper do
        td { name }
        td { pulled }
        td { actions }
      end
    end

    def wrapper(&)
      div class: 'source', data: { test_id: 'repository' } do
        table class: 'w-full' do
          tbody do
            tr class: 'focus:outline-none h-16', &
          end
        end
      end
    end

    def name
      div class: 'flex items-center pl-5' do
        icon :circle, class: status_class

        div class: 'text-base font-medium leading-none ml-4 mr-2' do
          plain repository.name
        end

        div class: 'ml-2 dimmed hidden md:block' do
          provider
          branch
        end
      end
    end

    def pulled
      return if repository.pulled_at.blank?

      div class: 'flex items-center justify-end hidden md:block' do
        span class: 'tag' do
          plain "Pulled at #{pulled_at}"
        end
      end
    end

    def actions
      div class: 'flex items-center justify-end pr-5' do
        if repository.status.active?
          stop!
        else
          track!
        end
      end
    end

    def stop!
      turbo_frame id: "stop_tracking_#{repository.id}" do
        a href: stop_path, **stop_attrs do
          icon 'trash', class: 'mr-2'
          span(class: 'hidden md:inline') { 'Stop tracking' }
          span(class: 'inline md:hidden') { 'Stop' }
        end
      end
    end

    def track!
      turbo_frame id: "pull_#{repository.id}" do
        a href: track_path, **track_attrs do
          icon 'plug', class: 'mr-2'
          span(class: 'hidden md:inline') { 'Pull commits' }
          span(class: 'inline md:hidden') { 'Pull' }
        end
      end
    end

    def stop_path
      helpers.confirm_destroy_repository_path(repository)
    end

    def stop_attrs
      { class: 'button-delete inline-block whitespace-nowrap', data: { test_id: 'stop_tracking' } }
    end

    def track_path
      helpers.confirm_update_repository_path(repository)
    end

    def track_attrs
      { class: 'button-2 inline-block whitespace-nowrap', data: { test_id: 'pull_commits' } }
    end

    def status_class
      repository.status.active? ? 'text-green-500' : 'dimmed'
    end

    def branch
      span class: 'text-sm mr-2' do
        provider
      end

      icon :tag

      div class: 'text-sm leading-none ml-2 dimmed inline-block' do
        plain repository.branch
      end
    end

    def provider
      case repository.provider
      when 'github'
        'GitHub'
      end
    end

    def pulled_at
      helpers.l(repository.pulled_at, format: :long)
    end
  end
end
