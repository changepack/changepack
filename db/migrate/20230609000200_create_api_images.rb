class CreateAPIImages < ActiveRecord::Migration[7.0]
  def change
    create_table :api_images, id: :string do |t|
      t.timestamps
    end
  end
end
