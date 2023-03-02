# frozen_string_literal: true

class RepositoryComponent < ApplicationComponent
  attribute :repository, Types::Instance(Repository)
  register_element :turbo_frame

  def template
    wrapper do
      td { name }
      td { pulled }
      td { actions }
    end
  end

  def wrapper(&)
    div class: 'repository', data: { test_id: 'repository' } do
      table class: 'w-full whitespace-nowrap' do
        tbody do
          tr class: 'focus:outline-none h-16', &
        end
      end
    end
  end

  def name
    div class: 'flex items-center pl-5' do
      div class: 'mr-4' do
        icon :circle, class: status_class
      end

      div class: 'text-base font-medium leading-none mr-2' do
        text repository.name
      end

      div(class: 'ml-2 text-gray-400') { branch }
    end
  end

  def pulled
    return unless repository.pulled?

    div class: 'flex items-center justify-end' do
      span class: 'label' do
        text "Pulled at #{pulled_at}"
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
        text 'Stop tracking'
      end
    end
  end

  def track!
    turbo_frame id: "pull_commits_#{repository.id}" do
      a href: track_path, **track_attrs do
        icon 'plug', class: 'mr-2'
        text 'Pull commits'
      end
    end
  end

  def stop_path
    helpers.confirm_destroy_repository_path(repository)
  end

  def stop_attrs
    {
      class: 'button-delete inline-block',
      data: { test_id: 'stop_tracking' }
    }
  end

  def track_path
    helpers.confirm_update_repository_path(repository)
  end

  def track_attrs
    {
      class: 'button-2 inline-block',
      data: { test_id: 'pull_commits' }
    }
  end

  def status_class
    if repository.status.active?
      'text-green-500'
    else
      'text-gray-400'
    end
  end

  def branch
    icon :tag

    div class: 'text-sm leading-none ml-2 text-gray-400 inline-block' do
      text repository.branch
    end
  end

  def pulled_at
    helpers.l(repository.pulled, format: :long)
  end
end
