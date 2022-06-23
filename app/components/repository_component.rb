# frozen_string_literal: true

class RepositoryComponent < ApplicationComponent
  option :repository, model: Repository, optional: true
  option :repositories, type: Types::Relation | Types::Array.of(Types::Instance(Repository)), optional: true

  private

  def before_render
    return if repositories.nil?

    @pagy, @collection = repositories.is_a?(Array) ? pagy_array(repositories) : pagy(repositories)
  end

  def collection
    @collection ||= [repository, repositories].compact.flatten
  end

  def status_class(repository)
    if repository.status.active?
      'text-green-600'
    else
      'text-gray-400'
    end
  end
end
