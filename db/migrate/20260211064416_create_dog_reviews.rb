class CreateDogReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :dog_reviews do |t|
      t.references :dog, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
