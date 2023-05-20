class AddBearerToAPIKeys < ActiveRecord::Migration[7.0]
  def change
    change_table :api_keys do |t|
      t.references :bearer, polymorphic: true, index: true, type: :string
    end
  end
end
