class AddStockCounterCache < ActiveRecord::Migration
  def change
    add_column :tienda_products, :stock_count, :integer, null: false, default: 0
  end
end
