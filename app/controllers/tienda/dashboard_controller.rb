module Tienda
  class DashboardController < Tienda::ApplicationController

    before_filter { @active_nav = :root }

    def home
      @last_30_days_orders = {}
      end_date = Date.today
      start_date = end_date - 30.days
      last_30_days_orders = Tienda::Order.group('DATE(created_at)').where(created_at: start_date..end_date).count
      (start_date..end_date).each do |day|
        @last_30_days_orders[day] = last_30_days_orders[day] || 0
      end
      @sales_by_category = Tienda::Order.joins(products: [:product_category]).where(created_at: start_date..end_date).group('tienda_product_categories.name').count
      @users_count = Tienda::User.count
    end

  end
end
