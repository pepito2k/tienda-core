module Tienda
  class DashboardController < Tienda::ApplicationController

    before_filter { @active_nav = :root }

    def home

    end

  end
end
