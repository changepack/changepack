class AddUserIdToChangelogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :changelogs, :user, index: true, foreign_key: true, type: :string
  end
end
