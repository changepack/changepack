class RenamePulledToPulledAtOnRepositories < ActiveRecord::Migration[7.0]
  def change
    rename_column :repositories, :pulled, :pulled_at
  end
end
