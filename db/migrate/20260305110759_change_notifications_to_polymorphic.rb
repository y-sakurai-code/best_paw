class ChangeNotificationsToPolymorphic < ActiveRecord::Migration[6.1]
  def change
    execute "DELETE FROM notifications"
    remove_column :notifications, :review_id, :integer if column_exists?(:notifications, :review_id)
    add_reference :notifications, :subject, polymorphic: true, index: true
  end
end
