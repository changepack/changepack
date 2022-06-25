# frozen_string_literal: true

class RepositoryComponent < ApplicationComponent
  option :repository, model: Repository

  private

  def status_class(repository)
    if repository.status.active?
      'text-green-600'
    else
      'text-gray-400'
    end
  end
end
