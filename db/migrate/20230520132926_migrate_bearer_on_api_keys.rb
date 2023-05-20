class MigrateBearerOnAPIKeys < ActiveRecord::Migration[7.0]
  def change
    API::Key.find_each do |api_key|
      api_key.update!(bearer: api_key.account)
    end
  end
end
