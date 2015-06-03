class AddDocumentToOrders < ActiveRecord::Migration
  def change
    add_column :tienda_orders, :document, :integer
  end
end
