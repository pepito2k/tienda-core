class CreateTiendaInitialSchema < ActiveRecord::Migration
  def up
    create_table :tienda_countries do |t|
      t.string  :name
      t.string  :code2
      t.string  :code3
      t.string  :continent
      t.string  :tld
      t.string  :currency
      t.boolean :eu_member, default: false
    end

    create_table :tienda_delivery_service_prices do |t|
      t.integer  :delivery_service_id, index: true
      t.string   :code
      t.decimal  :price, precision: 8, scale: 2, index: true
      t.decimal  :cost_price, precision: 8, scale: 2
      t.integer  :tax_rate_id, index: true
      t.decimal  :min_weight, precision: 8, scale: 2, index: true
      t.decimal  :max_weight, precision: 8, scale: 2, index: true
      t.text     :country_ids
      t.timestamps
    end

    create_table :tienda_delivery_services do |t|
      t.string   :name
      t.string   :code
      t.boolean  :default, default: false
      t.boolean  :active, default: true, index: true
      t.string   :courier
      t.string   :tracking_url
      t.timestamps
    end

    create_table :tienda_order_items do |t|
      t.integer  :order_id, index: true
      t.integer  :ordered_item_id
      t.string   :ordered_item_type
      t.integer  :quantity, default: 1
      t.decimal  :unit_price, precision: 8, scale: 2
      t.decimal  :unit_cost_price, precision: 8, scale: 2
      t.decimal  :tax_amount, precision: 8, scale: 2
      t.decimal  :tax_rate, precision: 8, scale: 2
      t.decimal  :weight, precision: 8, scale: 3, default: nil
      t.timestamps
    end

    create_table :tienda_orders do |t|
      t.string   :token, index: true
      t.string   :first_name
      t.string   :last_name
      t.string   :company
      t.string   :billing_address1
      t.string   :billing_address2
      t.string   :billing_address3
      t.string   :billing_address4
      t.string   :billing_postcode
      t.integer  :billing_country_id, index: true
      t.string   :email_address
      t.string   :phone_number
      t.string   :status
      t.datetime :received_at, index: true
      t.datetime :accepted_at
      t.datetime :shipped_at
      t.integer  :delivery_service_id, index: true
      t.decimal  :delivery_price, precision: 8, scale: 2
      t.decimal  :delivery_cost_price, precision: 8, scale: 2
      t.decimal  :delivery_tax_rate, precision: 8, scale: 2
      t.decimal  :delivery_tax_amount, precision: 8, scale: 2
      t.integer  :accepted_by
      t.integer  :shipped_by
      t.string   :consignment_number
      t.datetime :rejected_at
      t.integer  :rejected_by
      t.string   :ip_address
      t.text     :notes
      t.boolean  :separate_delivery_address, default: false
      t.string   :delivery_name
      t.string   :delivery_address1
      t.string   :delivery_address2
      t.string   :delivery_address3
      t.string   :delivery_address4
      t.string   :delivery_postcode
      t.integer  :delivery_country_id, index: true
      t.decimal  :amount_paid, precision: 8, scale: 2, default: 0.0
      t.boolean  :exported, default: false
      t.string   :invoice_number
      t.timestamps
    end

    create_table :tienda_payments do |t|
      t.integer :order_id, index: true
      t.decimal :amount, precision: 8, scale: 2, default: 0.0
      t.string  :reference, :method
      t.boolean :confirmed, default: true
      t.boolean :refundable, default: false
      t.decimal :amount_refunded, precision: 8, scale: 2, default: 0.0
      t.integer :parent_payment_id, index: true
      t.boolean :exported, default: false
      t.timestamps
    end

    create_table :tienda_product_attributes do |t|
      t.integer  :product_id, index: true
      t.string   :key, index: true
      t.string   :value
      t.integer  :position, default: 1, index: true
      t.boolean  :searchable, default: true
      t.boolean  :public, default: true
      t.timestamps
    end

    create_table :tienda_product_categories do |t|
      t.string   :name
      t.string   :permalink, index: true
      t.text     :description
      t.timestamps
    end

    create_table :tienda_products do |t|
      t.integer  :parent_id, index: true
      t.integer  :product_category_id, index: true
      t.string   :name
      t.string   :sku, index: true
      t.string   :permalink
      t.text     :description
      t.text     :short_description
      t.boolean  :active, default: true
      t.decimal  :weight, precision: 8, scale: 3, default: 0.0
      t.decimal  :price, precision: 8, scale: 2, default: 0.0
      t.decimal  :cost_price, precision: 8, scale: 2, default: 0.0
      t.integer  :tax_rate_id, index: true
      t.boolean  :featured, default: false
      t.text     :in_the_box
      t.boolean  :stock_control, default: true
      t.boolean  :default, default: false
      t.timestamps
    end

    create_table :tienda_settings do |t|
      t.string :key, index: true
      t.string :value
      t.string :value_type
    end

    create_table :tienda_stock_level_adjustments do |t|
      t.integer  :item_id
      t.string   :item_type
      t.string   :description
      t.integer  :adjustment, default: 0
      t.string   :parent_type
      t.integer  :parent_id
      t.timestamps
    end

    create_table :tienda_tax_rates do |t|
      t.string   :name
      t.decimal  :rate, precision: 8, scale: 2
      t.string   :address_type
      t.text     :country_ids
      t.timestamps
    end

    create_table :tienda_users do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :email_address, index: true
      t.string   :password_digest
      t.timestamps
    end

    #Add indexes
    add_index :tienda_order_items, [:ordered_item_id, :ordered_item_type], name: 'index_tienda_order_items_ordered_item'

    add_index :tienda_stock_level_adjustments, [:item_id, :item_type], name: 'index_tienda_stock_level_adjustments_items'
    add_index :tienda_stock_level_adjustments, [:parent_id, :parent_type], name: 'index_tienda_stock_level_adjustments_parent'
  end

  def down
    [:users, :tax_rates, :stock_level_adjustments, :settings, :products, :product_categories, :product_attributes, :orders, :order_items, :delivery_services, :delivery_service_prices, :countries].each do |table|
      drop_table "tienda_#{table}"
    end
  end
end
