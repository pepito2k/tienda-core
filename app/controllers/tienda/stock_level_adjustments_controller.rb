module Tienda
  class StockLevelAdjustmentsController < ApplicationController

    before_filter { @item = Tienda::Product.find(params[:item_id].to_i) }
    before_filter { params[:id] && @sla = @item.stock_level_adjustments.find(params[:id].to_i) }

    def index
      @stock_level_adjustments = @item.stock_level_adjustments.ordered.page(params[:page]).per(10)
      @new_sla = @item.stock_level_adjustments.build if @new_sla.nil?
      if request.xhr?
        render action: 'index', layout: false
      end
    end

    def create
      @new_sla = @item.stock_level_adjustments.build(params[:stock_level_adjustment].permit(:description, :adjustment))
      if @new_sla.save
        if request.xhr?
          @new_sla = @item.stock_level_adjustments.build
          index
        else
          redirect_to stock_level_adjustments_path(item_id: params[:item_id], item_type: params[:item_type]), notice: t('tienda.stock_level_adjustments.create_notice')
        end
      else
        if request.xhr?
          render text: @new_sla.errors.full_messages.to_sentence, status: 422
        else
          index
          flash.now[:alert] = @new_sla.errors.full_messages.to_sentence
          render action: "index"
        end
      end
    end

  end
end
