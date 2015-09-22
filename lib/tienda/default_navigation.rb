require 'tienda/navigation_manager'

# This file defines all the default navigation managers used in Tienda.
# Of course, modules can make changes to these by removing them or adding their
# own. This file is loaded on application initialization so if you make changes,
# you'll need to restart the webserver.

#
# This is the default navigation manager for the admin interface.
#
Tienda::NavigationManager.build(:admin_primary) do
  add_item :root, icon: 'fa fa-dashboard'
  add_item :orders, icon: 'fa fa-money'
  add_item :products, icon: 'fa fa-barcode'
  add_item :product_categories, icon: 'fa fa-tags'
  add_item :delivery_services, icon: 'fa fa-truck'
  add_item :tax_rates, icon: 'fa fa-calculator'
  add_item :users, icon: 'fa fa-users'
  add_item :countries, icon: 'fa fa-flag'
  add_item :stats, icon: 'fa fa-line-chart'
  add_item :settings, icon: 'fa fa-gear'
end
