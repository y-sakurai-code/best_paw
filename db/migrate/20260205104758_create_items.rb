class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :admin_id
      t.integer :genre_id
      t.string :name
      t.text :introduction
      t.integer :estimated_dog_size
      t.integer :is_active

      t.timestamps
    end
  end
end
