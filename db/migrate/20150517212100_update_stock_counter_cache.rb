class UpdateStockCounterCache < ActiveRecord::Migration
  def change
    Tienda::StockLevelAdjustment.counter_culture_fix_counts
  end
end
