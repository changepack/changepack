class RenameChannelsToChannelInNotifications < ActiveRecord::Migration[7.1]
  def change
    rename_column :notifications, :channels, :channel
  end
end
