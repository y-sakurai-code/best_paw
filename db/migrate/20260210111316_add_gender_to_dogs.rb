class AddGenderToDogs < ActiveRecord::Migration[6.1]
  def change
    add_column :dogs, :gender, :integer
  end
end
