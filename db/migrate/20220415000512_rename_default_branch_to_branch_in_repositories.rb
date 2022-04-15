class RenameDefaultBranchToBranchInRepositories < ActiveRecord::Migration[7.0]
  def change
    rename_column :repositories, :default_branch, :branch
  end
end
