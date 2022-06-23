class AddPulledToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :pulled, :datetime
  end
end
