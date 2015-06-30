module Tienda
  class ProductsController < Tienda::ApplicationController

    before_filter { @active_nav = :products }
    before_filter { params[:id] && @product = Tienda::Product.root.find(params[:id]) }

    def index
      if params[:filter].blank?
        @products = Tienda::Product.root.includes(:stock_level_adjustments, :product_images, :product_category, :variants).order(:name).group_by(&:product_category).sort_by { |cat, pro| cat.name }
      else
        @products = Tienda::Product.root.send(params[:filter]).includes(:stock_level_adjustments, :product_images, :product_category, :variants).order(:name).group_by(&:product_category).sort_by { |cat, pro| cat.name }
      end
    end

    def new
      @product = Tienda::Product.new
    end

    def create
      @product = Tienda::Product.new(safe_params)
      if @product.save
        redirect_to :products, flash: { notice: t('tienda.products.create_notice') }
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @product.update(safe_params)
        redirect_to [:edit, @product], flash: { notice: t('tienda.products.update_notice') }
      else
        render :edit
      end
    end

    def destroy
      @product.destroy
      redirect_to :products, flash: { notice:  t('tienda.products.destroy_notice')}
    end

    def import
      if request.post?
        if params[:import].nil?
          redirect_to import_products_path, flash: { alert: I18n.t('tienda.imports.errors.no_file') }
        else
          Tienda::Product.import(params[:import][:import_file])
          redirect_to products_path, flash: { notice: I18n.t("tienda.products.imports.success") }
        end
      end
    end

    private

    def safe_params
      params[:product].permit(:product_category_id, :name, :sku, :permalink,
        :description, :short_description, :weight, :price, :cost_price,
        :tax_rate_id, :stock_control, :default_image_file, :second_image_file,
        :third_image_file, :fourth_image_file, :fifth_image_file,
        :data_sheet_file, :active, :featured, :in_the_box,
        :product_attributes_array => [:key, :value, :searchable, :public],
        :product_images_attributes => [:image, :_destroy, :id])
    end

  end
end
