class CreateFavoriteComments < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_comments do |t|
      t.integer :user_id
      t.integer :review_comments_id

      t.timestamps
    end
  end
end
