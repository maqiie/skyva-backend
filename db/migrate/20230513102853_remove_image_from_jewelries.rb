class RemoveImageFromJewelries < ActiveRecord::Migration[7.0]
  def change
    remove_column :jewelries, :image, :string
  end
end
