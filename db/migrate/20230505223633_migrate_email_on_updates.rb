class MigrateEmailOnUpdates < ActiveRecord::Migration[7.0]
  def change
    Update.where(email: nil).each do |update|
      update.update!(email: update.commit.author.email)
    end
  end
end
