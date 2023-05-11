class CreateJewelries < ActiveRecord::Migration[7.0]
  def change
    create_table :jewelries do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
