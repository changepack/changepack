# frozen_string_literal: true

class RepositoryComponent < LegacyApplicationComponent
  option :repository, Types::Instance(Repository)

  private

  def status_class(repository)
    if repository.status.active?
      'text-green-500'
    else
      'text-gray-400'
    end
  end
end
