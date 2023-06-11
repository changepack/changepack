# typed: false
# frozen_string_literal: true

module I
  class Team < ApplicationComponent
    attribute :team, ::Team

    def template
      render I::Box.new(data: { test_id: 'team' }) do
        td { name }
        td { pulled }
        td { actions }
      end
    end

    def name
      div class: 'flex items-center pl-5' do
        icon :circle, class: status_class

        div class: 'text-base font-medium leading-none ml-4 mr-2' do
          plain team.name
        end

        div class: 'ml-2 dimmed hidden md:block' do
          provider
        end
      end
    end

    def pulled
      return if team.pulled_at.blank?

      div class: 'flex items-center justify-end hidden md:block' do
        span class: 'tag' do
          plain "Pulled at #{pulled_at}"
        end
      end
    end

    def actions
      div class: 'flex items-center justify-end pr-5' do
        if team.status.active?
          stop!
        else
          track!
        end
      end
    end

    def stop!
      turbo_frame id: "stop_tracking_#{team.id}" do
        a href: stop_path, **stop_attrs do
          icon 'trash', class: 'mr-2'
          span(class: 'hidden md:inline') { 'Stop tracking' }
          span(class: 'inline md:hidden') { 'Stop' }
        end
      end
    end

    def track!
      turbo_frame id: "pull_#{team.id}" do
        a href: track_path, **track_attrs do
          icon 'plug', class: 'mr-2'
          span(class: 'hidden md:inline') { 'Pull issues' }
          span(class: 'inline md:hidden') { 'Pull' }
        end
      end
    end

    def stop_path
      helpers.confirm_destroy_team_path(team)
    end

    def stop_attrs
      { class: 'button-delete inline-block whitespace-nowrap', data: { test_id: 'stop_tracking' } }
    end

    def track_path
      helpers.confirm_update_team_path(team)
    end

    def track_attrs
      { class: 'button-2 inline-block whitespace-nowrap', data: { test_id: 'pull_commits' } }
    end

    def status_class
      if team.status.active?
        'text-green-500'
      else
        'dimmed'
      end
    end

    def provider
      span class: 'text-sm mr-2' do
        case team.provider
        when 'linear'
          'Linear'
        end
      end
    end

    def pulled_at
      helpers.l(team.pulled_at, format: :long)
    end
  end
end
