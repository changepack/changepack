class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories, id: :string do |t|
      t.belongs_to :account, index: true, foreign_key: true, type: :string
      t.belongs_to :user, index: true, foreign_key: true, type: :string
      t.string :name, null: false
      t.string :default_branch, null: false
      t.string :provider, null: false
      t.string :provider_id, null: false
      t.string :status, null: false, default: 'inactive'
      t.timestamps
    end
  end
end
