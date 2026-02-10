class AddIsArchivedToDogs < ActiveRecord::Migration[6.1]
  def change
    add_column :dogs, :is_archived, :boolean, default: false
  end
end
