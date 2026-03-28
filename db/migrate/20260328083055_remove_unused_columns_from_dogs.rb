class RemoveUnusedColumnsFromDogs < ActiveRecord::Migration[6.1]
  def change
    remove_column :dogs, :introduction, :text
  end
end
