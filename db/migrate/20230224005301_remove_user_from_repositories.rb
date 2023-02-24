class RemoveUserFromRepositories < ActiveRecord::Migration[7.0]
  def change
    remove_column :repositories, :user_id, :string
  end
end
