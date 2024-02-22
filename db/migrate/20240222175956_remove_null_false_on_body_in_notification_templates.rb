class RemoveNullFalseOnBodyInNotificationTemplates < ActiveRecord::Migration[7.1]
  def change
    change_column_null :notification_templates, :body, true
  end
end
