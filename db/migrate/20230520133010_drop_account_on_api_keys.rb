class DropAccountOnAPIKeys < ActiveRecord::Migration[7.0]
  def change
    remove_reference :api_keys, :account, index: true, type: :string
  end
end
