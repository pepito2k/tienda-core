module Tienda
  class StatsController < Tienda::ApplicationController

    before_filter { @active_nav = :root }

    def index
      @products = Tienda::Order.includes(order_items: [:ordered_item]).accepted.map(&:order_items).flatten.map(&:ordered_item).uniq
    end

  end
end
