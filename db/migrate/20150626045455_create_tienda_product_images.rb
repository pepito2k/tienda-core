class CreateTiendaProductImages < ActiveRecord::Migration
  def change
    create_table :tienda_product_images do |t|
      t.references :product, index: true
      t.string :image

      t.timestamps null: false
    end
    add_column :tienda_product_categories, :image, :string
    # add_foreign_key :tienda_product_images, :products
  end
end
