class AddImageToJewelries < ActiveRecord::Migration[7.0]
  def change
    add_column :jewelries, :image, :string
  end
end
