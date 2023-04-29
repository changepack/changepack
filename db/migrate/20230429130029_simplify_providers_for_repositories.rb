class SimplifyProvidersForRepositories < ActiveRecord::Migration[7.0]
  def change
    ActiveRecord::Base.transaction do
      User.find_each do |user|
        user.update!(providers: { github: user.github['id'] }) if user.github.present?
      end

      Repository.find_each do |repository|
        repository.update!(providers: { github: repository.github['id'] }) if repository.github.present?
      end
    end
  end
end
