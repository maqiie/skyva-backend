class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.integer "cart_id", null: false
      t.integer "item_id", null: false
      t.integer "jewelry_id" # Add the jewelry_id column
      t.integer "quantity"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["cart_id"], name: "index_cart_items_on_cart_id"
      t.index ["item_id"], name: "index_cart_items_on_item_id"
    end
  end
end
