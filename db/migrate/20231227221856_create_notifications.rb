class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.boolean :seen, default: false
      t.string :content
      t.bigint :user_id, null: false
      t.bigint :room_id, null: false

      t.timestamps
    end

    add_index :notifications, :room_id, name: 'index_notifications_on_room_id'
    add_index :notifications, :user_id, name: 'index_notifications_on_user_id'
  end
end
