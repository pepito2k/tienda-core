class AddParentIdToCategories < ActiveRecord::Migration
  def change
    add_column :tienda_product_categories, :parent_id, :int, index: true
  end
end
