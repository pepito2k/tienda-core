module Tienda
  class DashboardController < Tienda::ApplicationController

    def home
      redirect_to :orders
    end

  end
end
