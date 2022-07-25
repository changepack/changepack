class AddNullFalseToProvidersInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :commits, :providers, false
  end
end
