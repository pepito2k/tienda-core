class RemoveStockLevelItemPolymorphism < ActiveRecord::Migration
  def change
    rename_column :tienda_stock_level_adjustments, :item_id, :product_id
    remove_column :tienda_stock_level_adjustments, :item_type
  end
end
