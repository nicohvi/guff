class RenameHabtmTable < ActiveRecord::Migration
  def change
    rename_table :user_events, :events_users
  end
end
