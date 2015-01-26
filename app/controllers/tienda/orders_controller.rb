module Tienda
  class OrdersController < Tienda::ApplicationController

    before_filter { @active_nav = :orders }
    before_filter { params[:id] && @order = Tienda::Order.find(params[:id])}

    def index
      @query = Tienda::Order.ordered.received.includes(:order_items => :ordered_item).page(params[:page]).search(params[:q])
      @orders = @query.result
    end

    def new
      @order = Tienda::Order.new
      @order.order_items.build(ordered_item_type: 'Tienda::Product')
    end

    def create
      Tienda::Order.transaction do
        @order = Tienda::Order.new(safe_params)
        @order.status = 'confirming'
        if !request.xhr? && @order.save
          @order.confirm!
          redirect_to @order, notice: t('tienda.orders.create_notice')
        else
          @order.order_items.build(ordered_item_type: 'Tienda::Product')
          render action: "new"
        end
      end
    rescue Tienda::Errors::InsufficientStockToFulfil => e
      flash.now[:alert] = t('tienda.orders.insufficient_stock_order', out_of_stock_items: e.out_of_stock_items.map { |t| t.ordered_item.full_name }.to_sentence)
      render action: 'new'
    end

    def show
      @payments = @order.payments.to_a
    end

    def update
      @order.attributes = safe_params
      if !request.xhr? && @order.update_attributes(safe_params)
        redirect_to @order, notice: t('tienda.orders.update_notice')
      else
        render action: "edit"
      end
    end

    def search
      index
      render action: "index"
    end

    def accept
      @order.accept!(current_user)
      redirect_to @order, notice: t('tienda.orders.accept_notice')
    rescue Tienda::Errors::PaymentDeclined => e
      redirect_to @order, alert: e.message
    end

    def reject
      @order.reject!(current_user)
      redirect_to @order, notice: t('tienda.orders.reject_notice')
    rescue Tienda::Errors::PaymentDeclined => e
      redirect_to @order, alert: e.message
    end

    def ship
      @order.ship!(params[:consignment_number], current_user)
      redirect_to @order, notice: t('tienda.orders.ship_notice')
    end

    def despatch_note
      render layout: 'tienda/printable'
    end

    private

    def safe_params
      params[:order].permit(
        :first_name, :last_name, :company,
        :billing_address1, :billing_address2, :billing_address3, :billing_address4, :billing_postcode, :billing_country_id,
        :separate_delivery_address,
        :delivery_name, :delivery_address1, :delivery_address2, :delivery_address3, :delivery_address4, :delivery_postcode, :delivery_country_id,
        :delivery_price, :delivery_service_id, :delivery_tax_amount,
        :email_address, :phone_number,
        :notes,
        :order_items_attributes => [:ordered_item_id, :ordered_item_type, :quantity, :unit_price, :tax_amount, :id, :weight]
      )
    end
  end
end
