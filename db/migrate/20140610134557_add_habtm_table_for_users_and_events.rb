class AddHabtmTableForUsersAndEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.references :user
      t.references :event
    end
    add_index :user_events, :user_id
    add_index :user_events, :event_id
    add_index :user_events, [:user_id, :event_id], unique: true
  end
end
