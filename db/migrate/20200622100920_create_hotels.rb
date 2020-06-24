class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.float :price
      t.integer :reviews
      t.float :review_score
      t.text :description
      t.text :location
      t.timestamps
    end
  end
end
