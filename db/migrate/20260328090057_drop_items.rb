class DropItems < ActiveRecord::Migration[6.1]
  def change
    drop_table :items do |t|
      t.integer "admin_id"
      t.integer "genre_id"
      t.string "name"
      t.text "introduction"
      t.integer "estimated_dog_size"
      t.integer "is_active"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end
