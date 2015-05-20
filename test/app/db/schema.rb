# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150517212100) do

  create_table "nifty_attachments", force: :cascade do |t|
    t.integer  "parent_id",   limit: 4
    t.string   "parent_type", limit: 255
    t.string   "token",       limit: 255
    t.string   "digest",      limit: 255
    t.string   "role",        limit: 255
    t.string   "file_name",   limit: 255
    t.string   "file_type",   limit: 255
    t.binary   "data",        limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nifty_key_value_store", force: :cascade do |t|
    t.integer "parent_id",   limit: 4
    t.string  "parent_type", limit: 255
    t.string  "group",       limit: 255
    t.string  "name",        limit: 255
    t.string  "value",       limit: 255
  end

  create_table "tienda_countries", force: :cascade do |t|
    t.string  "name",      limit: 255
    t.string  "code2",     limit: 255
    t.string  "code3",     limit: 255
    t.string  "continent", limit: 255
    t.string  "tld",       limit: 255
    t.string  "currency",  limit: 255
    t.boolean "eu_member", limit: 1,   default: false
  end

  create_table "tienda_delivery_service_prices", force: :cascade do |t|
    t.integer  "delivery_service_id", limit: 4
    t.string   "code",                limit: 255
    t.decimal  "price",                             precision: 8, scale: 2
    t.decimal  "cost_price",                        precision: 8, scale: 2
    t.integer  "tax_rate_id",         limit: 4
    t.decimal  "min_weight",                        precision: 8, scale: 2
    t.decimal  "max_weight",                        precision: 8, scale: 2
    t.text     "country_ids",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tienda_delivery_service_prices", ["delivery_service_id"], name: "index_tienda_delivery_service_prices_on_delivery_service_id", using: :btree
  add_index "tienda_delivery_service_prices", ["max_weight"], name: "index_tienda_delivery_service_prices_on_max_weight", using: :btree
  add_index "tienda_delivery_service_prices", ["min_weight"], name: "index_tienda_delivery_service_prices_on_min_weight", using: :btree
  add_index "tienda_delivery_service_prices", ["price"], name: "index_tienda_delivery_service_prices_on_price", using: :btree
  add_index "tienda_delivery_service_prices", ["tax_rate_id"], name: "index_tienda_delivery_service_prices_on_tax_rate_id", using: :btree

  create_table "tienda_delivery_services", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "code",         limit: 255
    t.boolean  "default",      limit: 1,   default: false
    t.boolean  "active",       limit: 1,   default: true
    t.string   "courier",      limit: 255
    t.string   "tracking_url", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tienda_delivery_services", ["active"], name: "index_tienda_delivery_services_on_active", using: :btree

  create_table "tienda_order_items", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.integer  "ordered_item_id",   limit: 4
    t.string   "ordered_item_type", limit: 255
    t.integer  "quantity",          limit: 4,                           default: 1
    t.decimal  "unit_price",                    precision: 8, scale: 2
    t.decimal  "unit_cost_price",               precision: 8, scale: 2
    t.decimal  "tax_amount",                    precision: 8, scale: 2
    t.decimal  "tax_rate",                      precision: 8, scale: 2
    t.decimal  "weight",                        precision: 8, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tienda_order_items", ["order_id"], name: "index_tienda_order_items_on_order_id", using: :btree
  add_index "tienda_order_items", ["ordered_item_id", "ordered_item_type"], name: "index_tienda_order_items_ordered_item", using: :btree

  create_table "tienda_orders", force: :cascade do |t|
    t.string   "token",                     limit: 255
    t.string   "first_name",                limit: 255
    t.string   "last_name",                 limit: 255
    t.string   "company",                   limit: 255
    t.string   "billing_address1",          limit: 255
    t.string   "billing_address2",          limit: 255
    t.string   "billing_address3",          limit: 255
    t.string   "billing_address4",          limit: 255
    t.string   "billing_postcode",          limit: 255
    t.integer  "billing_country_id",        limit: 4
    t.string   "email_address",             limit: 255
    t.string   "phone_number",              limit: 255
    t.string   "status",                    limit: 255
    t.datetime "received_at"
    t.datetime "accepted_at"
    t.datetime "shipped_at"
    t.integer  "delivery_service_id",       limit: 4
    t.decimal  "delivery_price",                          precision: 8, scale: 2
    t.decimal  "delivery_cost_price",                     precision: 8, scale: 2
    t.decimal  "delivery_tax_rate",                       precision: 8, scale: 2
    t.decimal  "delivery_tax_amount",                     precision: 8, scale: 2
    t.integer  "accepted_by",               limit: 4
    t.integer  "shipped_by",                limit: 4
    t.string   "consignment_number",        limit: 255
    t.datetime "rejected_at"
    t.integer  "rejected_by",               limit: 4
    t.string   "ip_address",                limit: 255
    t.text     "notes",                     limit: 65535
    t.boolean  "separate_delivery_address", limit: 1,                             default: false
    t.string   "delivery_name",             limit: 255
    t.string   "delivery_address1",         limit: 255
    t.string   "delivery_address2",         limit: 255
    t.string   "delivery_address3",         limit: 255
    t.string   "delivery_address4",         limit: 255
    t.string   "delivery_postcode",         limit: 255
    t.integer  "delivery_country_id",       limit: 4
    t.decimal  "amount_paid",                             precision: 8, scale: 2, default: 0.0
    t.boolean  "exported",                  limit: 1,                             default: false
    t.string   "invoice_number",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tienda_orders", ["billing_country_id"], name: "index_tienda_orders_on_billing_country_id", using: :btree
  add_index "tienda_orders", ["delivery_country_id"], name: "index_tienda_orders_on_delivery_country_id", using: :btree
  add_index "tienda_orders", ["delivery_service_id"], name: "index_tienda_orders_on_delivery_service_id", using: :btree
  add_index "tienda_orders", ["received_at"], name: "index_tienda_orders_on_received_at", using: :btree
  add_index "tienda_orders", ["token"], name: "index_tienda_orders_on_token", using: :btree

  create_table "tienda_payments", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.decimal  "amount",                        precision: 8, scale: 2, default: 0.0
    t.string   "reference",         limit: 255
    t.string   "method",            limit: 255
    t.boolean  "confirmed",         limit: 1,                           default: true
    t.boolean  "refundable",        limit: 1,                           default: false
    t.decimal  "amount_refunded",               precision: 8, scale: 2, default: 0.0
    t.integer  "parent_payment_id", limit: 4
    t.boolean  "exported",          limit: 1,                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tienda_payments", ["order_id"], name: "index_tienda_payments_on_order_id", using: :btree
  add_index "tienda_payments", ["parent_payment_id"], name: "index_tienda_payments_on_parent_payment_id", using: :btree

  create_table "tienda_product_attributes", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.integer  "position",   limit: 4,   default: 1
    t.boolean  "searchable", limit: 1,   default: true
    t.boolean  "public",     limit: 1,   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tienda_product_attributes", ["key"], name: "index_tienda_product_attributes_on_key", using: :btree
  add_index "tienda_product_attributes", ["position"], name: "index_tienda_product_attributes_on_position", using: :btree
  add_index "tienda_product_attributes", ["product_id"], name: "index_tienda_product_attributes_on_product_id", using: :btree

  create_table "tienda_product_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "permalink",   limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tienda_product_categories", ["permalink"], name: "index_tienda_product_categories_on_permalink", using: :btree

  create_table "tienda_products", force: :cascade do |t|
    t.integer  "parent_id",           limit: 4
    t.integer  "product_category_id", limit: 4
    t.string   "name",                limit: 255
    t.string   "sku",                 limit: 255
    t.string   "permalink",           limit: 255
    t.text     "description",         limit: 65535
    t.text     "short_description",   limit: 65535
    t.boolean  "active",              limit: 1,                             default: true
    t.decimal  "weight",                            precision: 8, scale: 3, default: 0.0
    t.decimal  "price",                             precision: 8, scale: 2, default: 0.0
    t.decimal  "cost_price",                        precision: 8, scale: 2, default: 0.0
    t.integer  "tax_rate_id",         limit: 4
    t.boolean  "featured",            limit: 1,                             default: false
    t.text     "in_the_box",          limit: 65535
    t.boolean  "stock_control",       limit: 1,                             default: true
    t.boolean  "default",             limit: 1,                             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_count",         limit: 4,                             default: 0,     null: false
  end

  add_index "tienda_products", ["parent_id"], name: "index_tienda_products_on_parent_id", using: :btree
  add_index "tienda_products", ["product_category_id"], name: "index_tienda_products_on_product_category_id", using: :btree
  add_index "tienda_products", ["sku"], name: "index_tienda_products_on_sku", using: :btree
  add_index "tienda_products", ["tax_rate_id"], name: "index_tienda_products_on_tax_rate_id", using: :btree

  create_table "tienda_settings", force: :cascade do |t|
    t.string "key",        limit: 255
    t.string "value",      limit: 255
    t.string "value_type", limit: 255
  end

  add_index "tienda_settings", ["key"], name: "index_tienda_settings_on_key", using: :btree

  create_table "tienda_stock_level_adjustments", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.string   "description", limit: 255
    t.integer  "adjustment",  limit: 4,   default: 0
    t.string   "parent_type", limit: 255
    t.integer  "parent_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tienda_stock_level_adjustments", ["parent_id", "parent_type"], name: "index_tienda_stock_level_adjustments_parent", using: :btree
  add_index "tienda_stock_level_adjustments", ["product_id"], name: "index_tienda_stock_level_adjustments_items", using: :btree

  create_table "tienda_tax_rates", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.decimal  "rate",                       precision: 8, scale: 2
    t.string   "address_type", limit: 255
    t.text     "country_ids",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tienda_users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email_address",   limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tienda_users", ["email_address"], name: "index_tienda_users_on_email_address", using: :btree

end
