class CreateDogs < ActiveRecord::Migration[6.1]
  def change
    create_table :dogs do |t|
      t.integer :user_id
      t.string :name
      t.string :breed
      t.date :birthday
      t.integer :size
      t.text :introduction

      t.timestamps
    end
  end
end
