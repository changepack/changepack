class AddUniqueIndexOnProvidersInCommits < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :updates, column: :commit_id
    remove_index :updates, :commit_id
    add_index :updates, :commit_id, unique: true

    remove_foreign_key :sources, column: :repository_id
    remove_index :sources, :repository_id
    add_index :sources, :repository_id, unique: true

    commits = Commit.where(
      providers: Commit.select(:providers).group(:providers).having('COUNT(*) > 1')
    ).to_a

    repositories = Repository.where(
      providers: Repository.select(:providers).group(:providers).having('COUNT(*) > 1')
    ).to_a

    commits[1..-1]&.each(&:destroy)
    repositories[1..-1]&.each(&:destroy)

    add_index :commits, :providers, unique: true
    add_index :repositories, :providers, unique: true
  end

  def down
    remove_index :repositories, :providers
    remove_index :commits, :providers

    add_foreign_key :sources, :repositories, column: :repository_id
    add_foreign_key :updates, :commits, column: :commit_id
  end
end
