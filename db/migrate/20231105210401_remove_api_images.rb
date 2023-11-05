class RemoveAPIImages < ActiveRecord::Migration[7.0]
  def change
    drop_table :api_images
  end
end
